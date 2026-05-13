from django.contrib.auth.models import User
from dj_rest_auth.registration.serializers import RegisterSerializer
from rest_framework import serializers

from .models import FriendRequest, Follow, Order, Product, UserProfile


class UserSerializer(serializers.ModelSerializer):
    phone = serializers.SerializerMethodField()

    def get_phone(self, obj):
        profile = UserProfile.objects.filter(user=obj).first()
        return profile.phone if profile else ''

    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name', 'phone']


class CustomRegisterSerializer(RegisterSerializer):
    phone = serializers.CharField(max_length=20, required=False, allow_blank=True)

    def get_cleaned_data(self):
        data = super().get_cleaned_data()
        data['phone'] = self.validated_data.get('phone', '')
        return data

    def custom_signup(self, request, user):
        phone = self.cleaned_data.get('phone', '')
        if phone:
            profile, _ = UserProfile.objects.get_or_create(user=user)
            profile.phone = phone
            profile.save(update_fields=['phone'])


class FriendRequestSerializer(serializers.ModelSerializer):
    sender = UserSerializer(read_only=True)
    receiver = UserSerializer(read_only=True)
    sender_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(), write_only=True, source='sender'
    )
    receiver_id = serializers.PrimaryKeyRelatedField(
        queryset=User.objects.all(), write_only=True, source='receiver'
    )
    status_display = serializers.CharField(source='get_status_display', read_only=True)

    class Meta:
        model = FriendRequest
        fields = [
            'id',
            'sender',
            'receiver',
            'sender_id',
            'receiver_id',
            'status',
            'status_display',
            'created_at',
            'updated_at',
        ]
        read_only_fields = ['status', 'created_at', 'updated_at']


class FollowSerializer(serializers.ModelSerializer):
    follower = UserSerializer(read_only=True)
    followed = UserSerializer(read_only=True)

    class Meta:
        model = Follow
        fields = ['id', 'follower', 'followed', 'created_at']


class ProductSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    seller = serializers.CharField(source='user.username', read_only=True)
    seller_email = serializers.EmailField(source='user.email', read_only=True)
    price = serializers.DecimalField(max_digits=10, decimal_places=2)
    status = serializers.SerializerMethodField()

    def get_status(self, obj):
        sold_order = obj.orders.filter(status=Order.STATUS_SOLD).exists()
        if sold_order:
            return Order.STATUS_SOLD

        pending_order = obj.orders.filter(status=Order.STATUS_PENDING).exists()
        if pending_order:
            return Order.STATUS_PENDING

        return 'available'

    def to_representation(self, instance):
        representation = super().to_representation(instance)
        try:
            representation['price'] = str(int(instance.price)) if instance.price is not None else '0'
        except (TypeError, ValueError):
            representation['price'] = str(representation.get('price', '0'))
        return representation

    class Meta:
        model = Product
        fields = [
            'id',
            'user',
            'seller',
            'seller_email',
            'title',
            'description',
            'price',
            'image',
            'status',
            'created_at',
        ]
        read_only_fields = ['id', 'user', 'seller', 'seller_email', 'status', 'created_at']


class OrderSerializer(serializers.ModelSerializer):
    buyer = UserSerializer(read_only=True)
    product = ProductSerializer(read_only=True)
    product_id = serializers.PrimaryKeyRelatedField(
        queryset=Product.objects.all(),
        write_only=True,
        source='product',
    )
    seller = serializers.CharField(source='product.user.username', read_only=True)
    seller_id = serializers.CharField(source='product.user.id', read_only=True)
    status_display = serializers.CharField(source='get_status_display', read_only=True)

    class Meta:
        model = Order
        fields = [
            'id',
            'product',
            'product_id',
            'buyer',
            'seller',
            'seller_id',
            'status',
            'status_display',
            'phone',
            'address',
            'email',
            'created_at',
            'updated_at',
        ]
        read_only_fields = [
            'id',
            'buyer',
            'seller',
            'seller_id',
            'status',
            'status_display',
            'created_at',
            'updated_at',
        ]

    def create(self, validated_data):
        buyer = self.context['request'].user
        return Order.objects.create(buyer=buyer, **validated_data)
