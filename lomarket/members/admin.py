from django.contrib import admin
from .models import FriendRequest, Follow, Product, UserProfile


@admin.register(FriendRequest)
class FriendRequestAdmin(admin.ModelAdmin):
    list_display = ['id', 'sender', 'receiver', 'status', 'created_at']
    list_filter = ['status', 'created_at']
    search_fields = ['sender__username', 'receiver__username']


@admin.register(UserProfile)
class UserProfileAdmin(admin.ModelAdmin):
    list_display = ['id', 'user', 'phone']
    search_fields = ['user__username', 'user__email', 'phone']


@admin.register(Follow)
class FollowAdmin(admin.ModelAdmin):
    list_display = ['id', 'follower', 'followed', 'created_at']
    search_fields = ['follower__username', 'followed__username']


@admin.register(Product)
class ProductAdmin(admin.ModelAdmin):
    list_display = ['id', 'title', 'user', 'price', 'created_at']
    search_fields = ['title', 'user__username', 'user__email']
