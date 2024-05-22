import 'package:spotify_sdk/spotify_sdk.dart';
import 'package:spotify_sdk/models/player_state.dart';
import 'package:spotify_sdk/models/connection_status.dart';

class SpotifyService {
  Future<void> connectToSpotifyRemote() async {
    try {
      var result = await SpotifySdk.connectToSpotifyRemote(
        clientId: '1ed5bb8d12224cd696df45819134e9dc',
        redirectUrl: 'http://127.0.0.1:8000/',
      );
      print('Connected to Spotify: $result');
    } catch (e) {
      print('Failed to connect to Spotify: $e');
    }
  }

  Future<void> play(String spotifyUri) async {
    try {
      await SpotifySdk.play(spotifyUri: spotifyUri);
    } catch (e) {
      print('Failed to play: $e');
    }
  }

  Future<void> pause() async {
    try {
      await SpotifySdk.pause();
    } catch (e) {
      print('Failed to pause: $e');
    }
  }

  Stream<PlayerState> subscribePlayerState() {
    return SpotifySdk.subscribePlayerState();
  }
}
