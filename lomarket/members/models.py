from django.db import models
from django.contrib.auth.models import User


class FriendRequest(models.Model):
    STATUS_PENDING = 'pending'
    STATUS_ACCEPTED = 'accepted'
    STATUS_REJECTED = 'rejected'

    STATUS_CHOICES = [
        (STATUS_PENDING, 'Pending'),
        (STATUS_ACCEPTED, 'Accepted'),
        (STATUS_REJECTED, 'Rejected'),
    ]

    sender = models.ForeignKey(
        User, related_name='sent_friend_requests', on_delete=models.CASCADE
    )
    receiver = models.ForeignKey(
        User, related_name='received_friend_requests', on_delete=models.CASCADE
    )
    status = models.CharField(max_length=10, choices=STATUS_CHOICES, default=STATUS_PENDING)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = 'Friend Request'
        verbose_name_plural = 'Friend Requests'
        ordering = ['-created_at']

    def accept(self):
        self.status = self.STATUS_ACCEPTED
        self.save(update_fields=['status', 'updated_at'])

    def reject(self):
        self.status = self.STATUS_REJECTED
        self.save(update_fields=['status', 'updated_at'])

    def __str__(self):
        return f"{self.sender} -> {self.receiver} ({self.status})"


class Follow(models.Model):
    follower = models.ForeignKey(
        User, related_name="following", on_delete=models.CASCADE
    )
    followed = models.ForeignKey(
        User, related_name="followers", on_delete=models.CASCADE
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('follower', 'followed')
        ordering = ['-created_at']

    def __str__(self):
        return f"{self.follower} follows {self.followed}"


class Product(models.Model):
    user = models.ForeignKey(User, related_name="products", on_delete=models.CASCADE)
    title = models.CharField(max_length=255)
    description = models.TextField(blank=True)
    price = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    image = models.URLField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        ordering = ['-created_at']

    def __str__(self):
        return self.title
