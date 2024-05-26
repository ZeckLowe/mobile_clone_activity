import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee_widget/marquee_widget.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/models/models.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:collection/collection.dart';
import 'package:audioplayers/audioplayers.dart';

class MusicPlayerView extends ConsumerStatefulWidget {
  final int initialId;

  MusicPlayerView({Key? key, required this.initialId}) : super(key: key);

  @override
  _MusicPlayerViewState createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends ConsumerState<MusicPlayerView> {
  final audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;
  late int currentId;

  @override
  void initState() {
    super.initState();
    currentId = widget.initialId;

    /// Listen to states: playing, paused, stopped
    audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        isPlaying = state == PlayerState.playing;
      });
    });

    /// Listen to audio duration
    audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        duration = newDuration;
      });
    });

    /// Listen to audio position
    audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        position = newPosition;
      });
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  void playSong(Song song) async {
    await audioPlayer.play(UrlSource(song.songUrl));
  }

  void playNextSong(List<Song> songs) {
    final currentIndex = songs.indexWhere((song) => song.id == currentId);
    if (currentIndex != -1 && currentIndex < songs.length - 1) {
      setState(() {
        currentId = songs[currentIndex + 1].id ?? 0;
      });
    }
  }

  void playPreviousSong(List<Song> songs) async {
    final currentIndex = songs.indexWhere((song) => song.id == currentId);
    if (currentIndex > 0) {
      setState(() {
        currentId = songs[currentIndex - 1].id ?? 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final songAsyncValue = ref.watch(songProvider);

    return Scaffold(
      body: songAsyncValue.when(
        data: (songs) {
          final song = songs.firstWhereOrNull((s) => s.id == currentId);
          if (song != null) {
            return Stack(
              children: [
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
                  backgroundColor: Colors.transparent,
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
                              Slider(
                                min: 0,
                                max: duration.inSeconds.toDouble(),
                                value: position.inSeconds.toDouble(),
                                onChanged: (value) async {
                                  final position =
                                      Duration(seconds: value.toInt());
                                  await audioPlayer.seek(position);
                                  await audioPlayer.resume();
                                },
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 16),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(formatDuration(position)),
                                    Text(formatDuration(duration - position))
                                  ],
                                ),
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
                                    onPressed: () async {
                                      playPreviousSong(songs);
                                      await audioPlayer.stop();
                                      await audioPlayer.seek(Duration.zero);
                                    },
                                    icon: Icon(Icons.skip_previous),
                                    iconSize: 36,
                                  ),
                                  IconButton(
                                    onPressed: () async {
                                      if (isPlaying) {
                                        await audioPlayer.pause();
                                      } else {
                                        await audioPlayer.play(
                                          UrlSource(song.songUrl),
                                          volume: 1.0,
                                        );
                                      }
                                    },
                                    icon: Icon(
                                      isPlaying
                                          ? Icons.pause_circle_filled_rounded
                                          : Icons.play_circle_filled_rounded,
                                    ),
                                    iconSize: 67,
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      playNextSong(songs);
                                    },
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

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.toString().padLeft(2, '0');
    final seconds = (duration.inSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
