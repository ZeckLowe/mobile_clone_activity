import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';

import '../providers/providers.dart';

class PlaylistPage extends ConsumerWidget {
  const PlaylistPage(
      {super.key,
      required this.playlistName,
      required this.image,
      required this.id});
  final String playlistName;
  final String image;
  final int id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double screenWidth = MediaQuery.of(context).size.width;
    final AsyncValue<List<User>> usersAsyncValue = ref.watch(userProvider);
    final AsyncValue<List<Song>> songsAsyncValue = ref.watch(songProvider);
    final AsyncValue<List<Playlist>> playlistAsyncValue =
        ref.watch(playlistProvider);
    final int currentPlayListId = 0;
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TopContainer(
                  screenWidth: screenWidth,
                  image: image,
                  playlistName: playlistName),
              SongsText(),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 320,
                width: screenWidth,
                // decoration: BoxDecoration(color: Colors.green),
                child: playlistAsyncValue.when(
                  data: (playlists) => usersAsyncValue.when(
                    data: (users) => songsAsyncValue.when(
                      data: (songs) {
                        List<int> songsList = playlists[id - 1].songs;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: songsList.length,
                          itemBuilder: (context, index) => Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: GestureDetector(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => PlaylistPage(
                                //       playlistName: userPlaylists[index].name,
                                //       image: "assets/album2.jpg",
                                //     ),
                                //   ),
                                // );
                              },
                              child: ListTile(
                                  leading: Container(
                                    height: 55,
                                    width: 55,
                                    child: Image.network(
                                      songs[songsList[index] - 1].image,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                  title: Text(
                                    songs[songsList[index] - 1].title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  subtitle: Text(
                                    songs[songsList[index] - 1].artist,
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

class SongsText extends StatelessWidget {
  const SongsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
      child: Row(
        children: [
          Text(
            "Songs",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            width: 285,
          ),
          GestureDetector(
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => addPlaylist(),
              //   ),
              // );
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
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  const TopContainer({
    super.key,
    required this.screenWidth,
    required this.image,
    required this.playlistName,
  });

  final double screenWidth;
  final String image;
  final String playlistName;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 15),
      height: 410,
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
      child: Stack(
        children: [
          backButton(),
          Center(
            child: Container(
              height: 230,
              width: 230,
              decoration: BoxDecoration(color: Colors.green),
              child: Image.asset(image),
            ),
          ),
          Positioned(
            top: 265,
            left: 90,
            child: Text(
              playlistName,
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Positioned(
            top: 320,
            width: 270,
            child: Text("Lorem Ipsum Ipsum Lorem Lorem Ipsum"),
          ),
          Positioned(
            top: 343,
            width: 270,
            child: Row(
              children: [
                Container(
                  height: 20,
                  width: 20,
                  child: Image.asset('assets/logo.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Spotify",
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                )
              ],
            ),
          ),
          Positioned(
              top: 365, width: 270, child: Text('1,629,592 likes . 6h 48m'))
        ],
      ),
    );
  }
}

class backButton extends StatelessWidget {
  const backButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        height: 25,
        width: 25,
        // decoration: BoxDecoration(
        //   color: Colors.black,
        // ),
        child: Image.asset(
          'assets/Chevron left.png',
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
