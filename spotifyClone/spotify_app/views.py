import requests
from django.conf import settings
from rest_framework.decorators import api_view
from rest_framework.response import Response
from rest_framework import status
from .models import SpotifyToken
from .utils import get_user_tokens, update_or_create_user_tokens

CLIENT_ID = '1ed5bb8d12224cd696df45819134e9dc'
CLIENT_SECRET = '384c3c3a36e249c886f6b811e0f63120'
REDIRECT_URI = 'http://127.0.0.1:8000/'

@api_view(['GET'])
def spotify_auth(request):
    scopes = 'user-read-playback-state user-modify-playback-state'
    url = f'https://accounts.spotify.com/authorize?client_id={CLIENT_ID}&response_type=code&redirect_uri={REDIRECT_URI}&scope={scopes}'
    return Response({'url': url}, status=status.HTTP_200_OK)

@api_view(['POST'])
def spotify_callback(request):
    code = request.data.get('code')
    response = requests.post('https://accounts.spotify.com/api/token', data={
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': REDIRECT_URI,
        'client_id': CLIENT_ID,
        'client_secret': CLIENT_SECRET,
    })
    if response.status_code != 200:
        return Response({'error': 'Failed to authenticate'}, status=status.HTTP_400_BAD_REQUEST)
    
    response_data = response.json()
    access_token = response_data.get('access_token')
    token_type = response_data.get('token_type')
    expires_in = response_data.get('expires_in')
    refresh_token = response_data.get('refresh_token')

    update_or_create_user_tokens(request.user, access_token, token_type, expires_in, refresh_token)

    return Response({'message': 'Success'}, status=status.HTTP_200_OK)