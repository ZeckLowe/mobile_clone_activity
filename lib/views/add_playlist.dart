import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/library.dart';

class addPlaylist extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredSongs = ref.watch(filteredSongProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    // final String playlistName = ref.watch(playListNameProvider);

    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CreatePlaylistText(),
              SizedBox(
                height: 30,
              ),
              EnterPlaylistNameText(),
              PlayListNameTextField(),
              SizedBox(
                height: 20,
              ),
              CreatePlaylistbutton(
                  // addedSongs: addedSongs,
                  ),
              SizedBox(
                height: 45,
              ),
              ChooseSongsText(),
              SizedBox(
                height: 10,
              ),
              Text_Field(
                screenWidth: screenWidth,
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: 430,
                width: screenWidth,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: filteredSongs.length,
                  itemBuilder: (context, index) => ListTile(
                    leading: Container(
                        height: 60,
                        width: 60,
                        child: Image.network(
                          filteredSongs[index].image,
                          fit: BoxFit.cover,
                        )),
                    subtitle: Text(filteredSongs[index].artist),
                    trailing: GestureDetector(
                      onTap: () {
                        print(filteredSongs[index].id);
                        ref
                            .read(addedSongsProvider.notifier)
                            .state
                            .add(filteredSongs[index].id!);
                        // addedSongs.add(filteredSongs[index].id!);
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
                    title: Text(
                      filteredSongs[index].title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CreatePlaylistbutton extends ConsumerWidget {
  const CreatePlaylistbutton({
    super.key,
    // required this.addedSongs
  });
  // final List<int> addedSongs;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String playlistName = ref.watch(playListNameProvider);
    final List<int> addedSongs = ref.watch(addedSongsProvider);
    return GestureDetector(
      onTap: () async {
        final int currentUserId = ref.read(userIdProvider);
        print(playlistName);
        print(currentUserId);
        print(addedSongs);
        await ref.read(addPlaylistProvider.notifier).addPlaylist(
              Playlist(
                name: playlistName,
                user: currentUserId,
                songs: addedSongs,
              ),
            );
        ref.read(addedSongsProvider.notifier).state = [];

        print(ref.read(addedSongsProvider));
        Navigator.pop(context);
      },
      child: Center(
        child: Container(
          height: 50,
          width: 140,
          decoration: BoxDecoration(
              color: Colors.grey, borderRadius: BorderRadius.circular(25)),
          child: Center(
            child: Text(
              'Create Playlist',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

class PlayListNameTextField extends ConsumerWidget {
  const PlayListNameTextField({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        hintText: 'Enter Name',
        hintStyle: TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
      onSubmitted: (value) {
        ref.read(playListNameProvider.notifier).state = value;
      },
    );
  }
}

class ChooseSongsText extends StatelessWidget {
  const ChooseSongsText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Choose Songs to Add to Playlist:',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class EnterPlaylistNameText extends StatelessWidget {
  const EnterPlaylistNameText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Enter Playlist Name:',
      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }
}

class CreatePlaylistText extends ConsumerWidget {
  const CreatePlaylistText({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            ref.read(searchTextProvider.notifier).state = '';
            Navigator.pop(context);
            FocusScope.of(context).unfocus();
          },
          child: Container(
            height: 50,
            width: 50,
            child: Image.asset(
              'assets/Chevron left.png',
            ),
          ),
        ),
        SizedBox(
          width: 65,
        ),
        Text(
          'Create Playlist',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class Text_Field extends ConsumerWidget {
  const Text_Field({
    super.key,
    required this.screenWidth,
  });
  final double screenWidth;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: screenWidth,
      height: 45,
      child: Row(
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            width: screenWidth - 105,
            height: 45,
            child: TextField(
              onChanged: (value) {
                ref.read(searchTextProvider.notifier).state = value;
              },
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Search Songs',
                hintStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
