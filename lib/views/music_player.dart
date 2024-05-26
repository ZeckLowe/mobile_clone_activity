import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:collection/collection.dart';

class MusicPlayerView extends ConsumerWidget {
  final int id;

  const MusicPlayerView({Key? key, required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final songAsyncValue = ref.watch(songProvider);

    return Scaffold(
      body: songAsyncValue.when(
        data: (songs) {
          final song = songs.firstWhereOrNull((s) => s.id == id);
          if (song != null) {
            return Stack(
              children: [
                // Apply the gradient directly to the Scaffold's body
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xff962419), Color(0xff430E09)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
                Scaffold(
                  backgroundColor: Colors
                      .transparent, // Set Scaffold's backgroundColor to transparent
                  body: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(26),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon:
                                        const Icon(CupertinoIcons.chevron_down),
                                    onPressed: () {},
                                    color: Colors.white,
                                  ),
                                  Text(
                                    song.album,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.white),
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.ellipsis),
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 81),
                              Container(
                                height: 380,
                                width: 380,
                                child: Image.network(song.image),
                              ),
                              const SizedBox(height: 67),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 300,
                                        height: 30,
                                        child: Marquee(
                                          child: Text(
                                            song.title,
                                            style: TextStyle(
                                                fontSize: 22,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        ),
                                      ),
                                      Text(
                                        song.artist,
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                      onPressed: () {},
                                      icon: const Icon(
                                          Icons.favorite_border_outlined))
                                ],
                              ),
                              Slider(value: 0, onChanged: (value) {}),
                              const Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [Text('0:00'), Text('0:00')],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    onPressed: () {},
                                    icon: const Icon(CupertinoIcons.shuffle),
                                    iconSize: 22,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.skip_previous),
                                    iconSize: 36,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon:
                                        Icon(Icons.pause_circle_filled_rounded),
                                    iconSize: 67,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.skip_next),
                                    iconSize: 36,
                                  ),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.repeat),
                                    iconSize: 22,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.share)),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(Icons.lyrics))
                                ],
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return Center(
              child: Text('Song not found'),
            );
          }
        },
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text('Error: $error')),
      ),
    );
  }
}
