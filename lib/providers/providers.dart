import 'package:flutter_riverpod/flutter_riverpod.dart';

final isChecked1Provider = StateProvider<bool>((ref) => false);
final isChecked2Provider = StateProvider<bool>((ref) => false);

final selectedTabProvider = StateProvider<int>((ref) => 0);

final songsProvider = Provider<List<String>>((ref) {
  return [
    "Treasure",
    "Grenade",
    "Just the Way You Are",
    "Talking to the Moon",
    "Finesse",
    "Locked Out of Heaven",
    "When I Was You Man",
    "That's What I Like",
    "Versace On The Floow",
    "Uptown Funk",
    "24K Magic",
    "Marry You",
    "The Lazy Song"
  ];
});

final displaySongsProvider =
    StateNotifierProvider<DisplaySongsNotifier, List<String>>((ref) {
  final songs = ref.watch(songsProvider);
  return DisplaySongsNotifier(songs);
});

class DisplaySongsNotifier extends StateNotifier<List<String>> {
  final List<String> _initialSongs;

  DisplaySongsNotifier(this._initialSongs) : super(_initialSongs);

  void updateList(String value) {
    if (value.isEmpty) {
      reset();
    } else {
      state = _initialSongs
          .where(
              (element) => element.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
  }

  void reset() {
    state = _initialSongs;
  }
}
