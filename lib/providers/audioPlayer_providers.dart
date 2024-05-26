import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';

class AudioPlayerNotifier extends StateNotifier<AudioPlayer> {
  AudioPlayerNotifier() : super(AudioPlayer());

  Future<void> loadSong(String url) async {
    try {
      await state.setUrl(url);
    } catch (e) {
      print('Error loading song: $e');
    }
  }

  void play() => state.play();
  void pause() => state.pause();
  void seek(Duration position) => state.seek(position);
}

final audioPlayerProvider =
    StateNotifierProvider<AudioPlayerNotifier, AudioPlayer>(
  (ref) => AudioPlayerNotifier(),
);
