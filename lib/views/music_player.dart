import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:mobile_clone_activity/service/spotify_sdk.dart';

class MusicPlayerView extends StatefulWidget {
  const MusicPlayerView({super.key});

  @override
  State<MusicPlayerView> createState() => _MusicPlayerViewState();
}

class _MusicPlayerViewState extends State<MusicPlayerView> {
  final SpotifyService _spotifyService = SpotifyService();
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _spotifyService.connectToSpotifyRemote();
  }

  void _togglePlayPause() {
    if (_isPlaying) {
      _spotifyService.pause();
    } else {
      _spotifyService.play('spotify:track:4cOdK2wGLETKBW3PvgPWqT');
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              icon: const Icon(CupertinoIcons.chevron_down),
                              onPressed: () {},
                              color: Colors.white,
                            ),
                            const Text(
                              '1(Remastered)',
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
                          color: Colors.blue,
                        ),
                        const SizedBox(height: 67),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: 300,
                                  height: 30,
                                  child: Marquee(
                                    text: 'From Me to You - Mono / Remastered',
                                    style: const TextStyle(
                                        fontSize: 22,
                                        fontWeight: FontWeight.w500),
                                    scrollAxis: Axis.horizontal,
                                    blankSpace: 20.0,
                                    velocity: 50.0,
                                    pauseAfterRound: const Duration(seconds: 1),
                                    startPadding: 27.0,
                                    accelerationDuration:
                                        const Duration(seconds: 1),
                                    accelerationCurve: Curves.linear,
                                    decelerationDuration:
                                        const Duration(milliseconds: 500),
                                    decelerationCurve: Curves.easeOut,
                                  ),
                                ),
                                const Text(
                                  'The Beatles',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.favorite_border_outlined))
                          ],
                        ),
                        Slider(value: 0, onChanged: (value) {}),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [Text('0:00'), Text('0:00')],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              onPressed: _togglePlayPause,
                              icon: Icon(_isPlaying
                                  ? Icons.pause_circle_filled
                                  : Icons.play_circle_fill),
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
                                onPressed: () {}, icon: Icon(Icons.share)),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.lyrics))
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
      ),
    );
  }
}
