from django.contrib.auth.models import User
from rest_framework import serializers
from .models import FriendRequest, Follow, Product

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'first_name', 'last_name']

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
    class Meta:
        model = Follow
        fields = ['id', 'follower', 'followed', 'created_at']


class ProductSerializer(serializers.ModelSerializer):
    class Meta:
        model = Product
        fields = ['id', 'user', 'title', 'description', 'price', 'image', 'created_at']
