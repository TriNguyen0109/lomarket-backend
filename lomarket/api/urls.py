from django.urls import path
from . import views


urlpatterns = [
    path('friend-requests/', views.FriendRequestListCreateAPIView.as_view(), name='friend-request-list-create'),
    path('friend-requests/<int:pk>/', views.FriendRequestDetailAPIView.as_view(), name='friend-request-detail'),
    path('friend-requests/<int:pk>/<str:action>/', views.FriendRequestActionAPIView.as_view(), name='friend-request-action'),
    
    path('users/', views.UserSearchAPIView.as_view(), name='user-search'),
    path('friends/', views.DirectFriendsAPIView.as_view(), name='direct-friends'),
    path('friends/<int:friend_id>/', views.RemoveFriendAPIView.as_view(), name='remove-friend'),
    path('follow/<int:user_id>/', views.FollowAPIView.as_view(), name='follow'),
    path('followed-users/', views.FollowedUsersAPIView.as_view(), name='followed-users'),
    path('followed-products/', views.FollowedProductsAPIView.as_view(), name='followed-products'),
]