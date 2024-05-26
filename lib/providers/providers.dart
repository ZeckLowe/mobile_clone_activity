import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_clone_activity/models/models.dart';

//Checkboxes in sign_up4 page
final isChecked1Provider = StateProvider<bool>((ref) => false);
final isChecked2Provider = StateProvider<bool>((ref) => false);

//login show/hide password icon
final showPassIconProvider = StateProvider<bool>((ref) => true);

//for adding playlist
final playListNameProvider = StateProvider<String>((ref) => '');

//navigation in tabbar
final selectedTabProvider = StateProvider<int>((ref) => 0);

//For library page showing profile
final currentUserProvider = StateProvider<String>((ref) => '');
final userIdProvider = StateProvider<int>((ref) => 0);

//For sign_up pages to be used for User Class initialization.
final userEmail = StateProvider<String>((ref) => '');
final gender = StateProvider<String>((ref) => '');
final password = StateProvider<String>((ref) => '');
final name = StateProvider<String>((ref) => '');

//For search page song filtering
final searchTextProvider = StateProvider<String>((ref) => '');

//Get request for songs.
final songProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.http('10.0.2.2:8000', '/api/v1/song/'));

  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final songList = jsonList.map((json) => Song.fromJson(json)).toList();

    return songList;
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
});

//Song filtering method
final filteredSongProvider = StateProvider<List<Song>>((ref) {
  final originalSongs = ref.watch(songProvider);
  final searchText = ref.watch(searchTextProvider);

  if (originalSongs is AsyncData<List<Song>>) {
    final songs = originalSongs.value;
    return songs.where((song) {
      final titleMatches =
          song.title.toLowerCase().contains(searchText.toLowerCase());

      return titleMatches;
    }).toList();
  } else {
    return [];
  }
});

//PERFORM GET REQUEST FROM THE API for USER
final userProvider = FutureProvider((ref) async {
  final response = await http.get(Uri.http('10.0.2.2:8000', '/api/v1/user/'));

  if (response.statusCode == 200) {
    final jsonList = jsonDecode(response.body) as List<dynamic>;
    final userList = jsonList.map((json) => User.fromJson(json)).toList();

    return userList;
  } else {
    throw Exception('Failed to load users: ${response.statusCode}');
  }
});

// PERFORM POST REQUEST for USER
final userCreateProvider = AsyncNotifierProvider<UserCreate, User>(
  UserCreate.new,
);

class UserCreate extends AsyncNotifier<User> {
  @override
  Future<User> build() async =>
      User(name: '', gender: '', email: '', password: '');

  Future<void> addUser(User user) async {
    try {
      final response = await http.post(
        Uri.http('10.0.2.2:8000', '/api/v1/user/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(user.toJson()),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User added successfully: ${response.body}");
        ref.refresh(userProvider);
      } else {
        print("Failed to add user: ${response.statusCode} ${response.body}");
      }
    } catch (e) {
      print("Failed to add user: $e");
    }
  }
}

//GET Request
final playlistProvider = FutureProvider((ref) async {
  try {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8000/api/v1/playlist/'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List<dynamic>;
      final playList = jsonList.map((json) => Playlist.fromJson(json)).toList();
      return playList;
    } else {
      throw Exception('Failed to load playlists: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('An unexpected error occurred: $e');
  }
});

// PERFORM POST REQUEST for playlist
final addPlaylistProvider = AsyncNotifierProvider<AddPlayList, Playlist>(
  AddPlayList.new,
);

class AddPlayList extends AsyncNotifier<Playlist> {
  @override
  Future<Playlist> build() async => Playlist(name: '', user: 0, songs: []);

  Future<void> addPlaylist(Playlist playlist) async {
    try {
      final response = await http.post(
        Uri.http('10.0.2.2:8000', '/api/v1/playlist/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(playlist.toJson()),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User added successfully: ${response.body}");
        ref.refresh(playlistProvider);
      } else {
        throw Exception(
            'Failed to add user: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      throw Exception('Failed to add user: $e');
    }
  }
}
