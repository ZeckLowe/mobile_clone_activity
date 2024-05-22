from django.db import models
from django.contrib.auth.models import User
# Create your models here.

class SpotifyToken(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    access_token = models.CharField(max_length=255)
    token_type = models.CharField(max_length=50)
    expires_in = models.DateTimeField()
    refresh_token = models.CharField(max_length=255)