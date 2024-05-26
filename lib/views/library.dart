import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/add_playlist.dart';
import 'package:mobile_clone_activity/views/album_view.dart';
import 'package:mobile_clone_activity/views/playlist_page.dart';
import 'package:mobile_clone_activity/widgets/album_card.dart';

class LibraryView extends ConsumerWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;
    final AsyncValue<List<Playlist>> playlistAsyncValue =
        ref.watch(playlistProvider);
    final AsyncValue<List<User>> usersAsyncValue = ref.watch(userProvider);
    final AsyncValue<List<Song>> songsAsyncValue = ref.watch(songProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(screenWidth: screenWidth),
              AddPlaylist(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 320,
                width: screenWidth,
                child: playlistAsyncValue.when(
                  data: (playlists) => usersAsyncValue.when(
                    data: (users) => songsAsyncValue.when(
                      data: (songs) {
                        final int currentUserId = ref.read(userIdProvider);
                        List<Playlist> userPlaylists = playlists
                            .where((playlist) => playlist.user == currentUserId)
                            .toList();
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: userPlaylists.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => PlaylistPage(
                                      playlistName: userPlaylists[index].name,
                                      id: userPlaylists[index].id!,
                                      image: "assets/album2.jpg",
                                    ),
                                  ),
                                );
                              },
                              child: ListTile(
                                  leading: Container(
                                      height: 60,
                                      width: 60,
                                      child: Image.asset('assets/album2.jpg')),
                                  title: Text(
                                    userPlaylists[index].name,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  trailing:
                                      Image.asset('assets/Arrow_right.png')),
                            ),
                          ),
                        );
                      },
                      error: (_, __) =>
                          Center(child: Text("An error occurred")),
                      loading: () => Center(child: CircularProgressIndicator()),
                    ),
                    error: (_, __) => Center(child: Text("An error occurred")),
                    loading: () => Center(child: CircularProgressIndicator()),
                  ),
                  loading: () => Center(child: CircularProgressIndicator()),
                  error: (_, __) => Center(child: Text("An error occurred")),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AddPlaylist extends StatelessWidget {
  const AddPlaylist({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
          child: Text(
            'Playlists',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(
          width: 255,
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => addPlaylist(),
              ),
            );
          },
          child: Container(
            height: 50,
            width: 50,
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ],
    );
  }
}

class TopContainer extends ConsumerWidget {
  const TopContainer({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String user = ref.read(currentUserProvider);
    return Container(
      height: 370,
      width: screenWidth,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 32, 110, 130),
            Color.fromARGB(255, 20, 68, 81),
            Color.fromARGB(255, 4, 15, 16),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 60,
            ),
            ProfilePic(),
            SizedBox(
              height: 5,
            ),
            Center(
              child: Text(
                user,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            EditProfile(),
            SizedBox(
              height: 40,
            ),
            Followers(),
          ],
        ),
      ),
    );
  }
}

class Followers extends StatelessWidget {
  const Followers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Column(
          children: [
            Text('23'), //Can be changed later based on number of playlists
            Text('Playlists'),
          ],
        ),
        Column(
          children: [
            Text('58'),
            Text('Followers'),
          ],
        ),
        Column(
          children: [
            Text('43'),
            Text('Following'),
          ],
        ),
      ],
    );
  }
}

class EditProfile extends StatelessWidget {
  const EditProfile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 40,
        width: 120,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 81, 81, 81),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            'Edit Profile',
            style: TextStyle(
                color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ProfilePic extends StatelessWidget {
  const ProfilePic({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 110,
        width: 110,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(55)),
        child: Image.asset('assets/Profile.png'),
      ),
    );
  }
}
