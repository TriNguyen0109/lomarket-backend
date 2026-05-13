from django.http import Http404
from django.shortcuts import get_object_or_404
from django.db.models import Q
from django.contrib.auth.models import User
from django.conf import settings
from django.core.files.storage import default_storage
from django.utils.text import get_valid_filename
from rest_framework import generics, serializers, status
from rest_framework.response import Response
from rest_framework.views import APIView
from rest_framework.permissions import IsAuthenticated
from rest_framework.renderers import JSONRenderer
from rest_framework.parsers import FormParser, JSONParser, MultiPartParser

from members.models import FriendRequest, Follow, Order, Product, UserProfile
from members.serializers import (
    FriendRequestSerializer,
    UserSerializer,
    FollowSerializer,
    OrderSerializer,
    ProductSerializer,
)


class FriendRequestListCreateAPIView(generics.ListCreateAPIView):
    serializer_class = FriendRequestSerializer
    queryset = FriendRequest.objects.all()

    def get_queryset(self):
        queryset = super().get_queryset()
        sender_id = self.request.query_params.get('sender_id')
        receiver_id = self.request.query_params.get('receiver_id')
        status_value = self.request.query_params.get('status')

        if sender_id:
            queryset = queryset.filter(sender_id=sender_id)
        if receiver_id:
            queryset = queryset.filter(receiver_id=receiver_id)
        if status_value:
            queryset = queryset.filter(status=status_value)
        return queryset

    def perform_create(self, serializer):
        serializer.save()


class FriendRequestDetailAPIView(generics.RetrieveAPIView):
    serializer_class = FriendRequestSerializer
    queryset = FriendRequest.objects.all()


class FriendRequestActionAPIView(APIView):
    def post(self, request, pk, action):
        friend_request = get_object_or_404(FriendRequest, pk=pk)

        if friend_request.status != FriendRequest.STATUS_PENDING:
            return Response(
                {'detail': 'Only pending requests can be updated.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        if action == 'accept':
            friend_request.accept()
        elif action == 'reject':
            friend_request.reject()
        else:
            return Response(
                {'detail': 'Action must be "accept" or "reject".'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        serializer = FriendRequestSerializer(friend_request)
        return Response(serializer.data, status=status.HTTP_200_OK)


class UserSearchAPIView(APIView):
    permission_classes = [IsAuthenticated]
    renderer_classes = [JSONRenderer]

    def get(self, request):
        email = request.query_params.get('email')
        if not email:
            return Response({"error": "Email parameter required"}, status=status.HTTP_400_BAD_REQUEST)

        try:
            users = User.objects.filter(email=email)
            if not users.exists():
                return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)

            if users.count() == 1:
                user = users.first()
                if user.id == request.user.id:
                    return Response({"error": "Cannot find yourself"}, status=status.HTTP_400_BAD_REQUEST)
                serializer = UserSerializer(user)
                return Response(serializer.data)

            # Có nhiều user trùng email, trả về danh sách để tránh lỗi MultipleObjectsReturned
            serializer = UserSerializer(users, many=True)
            return Response({"results": serializer.data})
        except Exception as exc:
            return Response(
                {"error": "Unexpected error while searching user", "details": str(exc)},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class DirectFriendsAPIView(generics.ListAPIView):
    serializer_class = UserSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        user_id = self.request.query_params.get('user_id')
        if not user_id:
            return User.objects.none()

        # Lấy danh sách bạn bè (accepted requests)
        accepted_requests = FriendRequest.objects.filter(
            Q(sender_id=user_id, status=FriendRequest.STATUS_ACCEPTED) |
            Q(receiver_id=user_id, status=FriendRequest.STATUS_ACCEPTED)
        )

        friend_ids = []
        for req in accepted_requests:
            if req.sender_id == int(user_id):
                friend_ids.append(req.receiver_id)
            else:
                friend_ids.append(req.sender_id)

        return User.objects.filter(id__in=friend_ids)


class RemoveFriendAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def delete(self, request, friend_id):
        user_id = request.query_params.get('user_id')
        if not user_id:
            return Response(
                {'detail': 'user_id parameter is required.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        # Xóa friendship (cả hai hướng)
        friend_request = FriendRequest.objects.filter(
            Q(sender_id=user_id, receiver_id=friend_id, status=FriendRequest.STATUS_ACCEPTED) |
            Q(sender_id=friend_id, receiver_id=user_id, status=FriendRequest.STATUS_ACCEPTED)
        ).first()

        if not friend_request:
            return Response(
                {'detail': 'Friendship not found.'},
                status=status.HTTP_404_NOT_FOUND,
            )

        friend_request.delete()
        return Response(
            {'detail': 'Friend removed successfully.'},
            status=status.HTTP_204_NO_CONTENT,
        )


class FollowAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, user_id):
        follower = request.user
        try:
            followed = User.objects.get(id=user_id)
            if follower == followed:
                return Response({"detail": "You cannot follow yourself."}, status=status.HTTP_400_BAD_REQUEST)

            follow, created = Follow.objects.get_or_create(follower=follower, followed=followed)
            if created:
                return Response({"detail": "Followed successfully."}, status=status.HTTP_201_CREATED)
            else:
                return Response({"detail": "You are already following this user."}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({"detail": "User not found."}, status=status.HTTP_404_NOT_FOUND)

    def delete(self, request, user_id):
        follower = request.user
        try:
            followed = User.objects.get(id=user_id)
            follow = Follow.objects.filter(follower=follower, followed=followed).first()
            if follow:
                follow.delete()
                return Response({"detail": "Unfollowed successfully."}, status=status.HTTP_204_NO_CONTENT)
            else:
                # Return 200 OK instead of error - idempotent unfollow
                return Response({"detail": "Not following this user (already unfollowed or never followed)."}, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response({"detail": "User not found."}, status=status.HTTP_404_NOT_FOUND)


class FollowedUsersAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        following = Follow.objects.filter(follower=request.user).select_related('followed')
        serializer = UserSerializer([f.followed for f in following], many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class FollowedProductsAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        following = Follow.objects.filter(follower=request.user).values_list('followed', flat=True)
        products = Product.objects.filter(user_id__in=following).exclude(
            orders__status__in=[Order.STATUS_PENDING, Order.STATUS_SOLD]
        ).select_related('user', 'user__profile').distinct()
        serializer = ProductSerializer(products, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProductListCreateAPIView(generics.ListCreateAPIView):
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]
    parser_classes = [MultiPartParser, FormParser, JSONParser]

    def get_queryset(self):
        return Product.objects.select_related('user', 'user__profile').all()

    def create(self, request, *args, **kwargs):
        data = request.data.copy()
        image = request.FILES.get('image')

        if image:
            try:
                filename = get_valid_filename(image.name or 'product.jpg')
                saved_path = default_storage.save(f'products/{filename}', image)
                # Use API_DOMAIN instead of request.build_absolute_uri()
                image_url = f"{settings.API_DOMAIN}{settings.MEDIA_URL}{saved_path}"
                print(f"DEBUG: Image saved to {saved_path}")
                print(f"DEBUG: Image URL = {image_url}")
                data['image'] = image_url
            except Exception as e:
                print(f"DEBUG: Image save failed: {str(e)}")
                return Response(
                    {'error': f'Failed to save image: {str(e)}'},
                    status=status.HTTP_400_BAD_REQUEST
                )

        serializer = self.get_serializer(data=data)
        serializer.is_valid(raise_exception=True)
        serializer.save(user=request.user)
        headers = self.get_success_headers(serializer.data)
        return Response(serializer.data, status=status.HTTP_201_CREATED, headers=headers)


class OrderListCreateAPIView(generics.ListCreateAPIView):
    serializer_class = OrderSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Order.objects.select_related(
            'buyer', 'product', 'product__user', 'product__user__profile'
        ).filter(
            Q(buyer=self.request.user) | Q(product__user=self.request.user)
        )

    def perform_create(self, serializer):
        product = serializer.validated_data['product']

        if product.user == self.request.user:
            raise serializers.ValidationError({
                'detail': 'You cannot buy your own product.'
            })

        if product.orders.filter(status__in=[Order.STATUS_PENDING, Order.STATUS_SOLD]).exists():
            raise serializers.ValidationError({
                'detail': 'This product already has a pending or sold order.'
            })

        serializer.save()


class OrderConfirmAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def post(self, request, pk):
        order = get_object_or_404(Order, pk=pk)

        if order.product.user != request.user:
            return Response({'detail': 'Not authorized to confirm this order.'}, status=status.HTTP_403_FORBIDDEN)

        if order.status != Order.STATUS_PENDING:
            return Response(
                {'detail': 'Only pending orders can be confirmed.'},
                status=status.HTTP_400_BAD_REQUEST,
            )

        order.status = Order.STATUS_SOLD
        order.save(update_fields=['status', 'updated_at'])
        serializer = OrderSerializer(order)
        return Response(serializer.data, status=status.HTTP_200_OK)


class ProductDetailAPIView(generics.RetrieveUpdateDestroyAPIView):
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Product.objects.filter(user=self.request.user).select_related('user', 'user__profile')


class MyProductsAPIView(generics.ListAPIView):
    serializer_class = ProductSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        return Product.objects.filter(user=self.request.user).select_related('user', 'user__profile')


class CurrentUserAPIView(APIView):
    permission_classes = [IsAuthenticated]

    def get(self, request):
        serializer = UserSerializer(request.user)
        return Response(serializer.data, status=status.HTTP_200_OK)

    def patch(self, request):
        user = request.user
        profile, _ = UserProfile.objects.get_or_create(user=user)

        first_name = request.data.get('first_name')
        last_name = request.data.get('last_name')
        email = request.data.get('email')
        phone = request.data.get('phone')

        if first_name is not None:
            user.first_name = first_name
        if last_name is not None:
            user.last_name = last_name
        if email is not None:
            user.email = email
        if phone is not None:
            profile.phone = phone

        user.save(update_fields=['first_name', 'last_name', 'email'])
        profile.save(update_fields=['phone'])

        serializer = UserSerializer(user)
        return Response(serializer.data, status=status.HTTP_200_OK)


