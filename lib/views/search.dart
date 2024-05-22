import 'package:flutter/material.dart';
import 'dart:math';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  final List<String> general = [
    'Podcasts',
    'Music',
    'Life Events',
    'Charts',
    'Made For You',
    'OPM',
    'New Releases',
    'Pop',
    'Hip-Hop',
  ];
  final List<String> genres = [
    'Pop',
    'Indie',
    'Country',
    'Ballad',
    'Jazz',
    'R&B',
  ];
  final List<String> podcast = [
    'Politics',
    'Comedy',
    'Sports',
    'Environment',
    'Dance',
    'Personal life',
  ];
  final List<Color> colors = [
    Colors.red,
    Colors.orange,
    Colors.yellow,
    Colors.green,
    Colors.blue,
    Colors.indigo,
    Colors.purple,
    Colors.deepPurple,
    Colors.lightBlue,
    Colors.teal,
  ];
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xff121212),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(15, 50, 15, 15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SearchText(),
            const SizedBox(
              height: 10,
            ),
            Text_Field(screenWidth: screenWidth),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Your top genres',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(screenWidth: screenWidth, items: genres, colors: colors),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Popular podcast categories',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            Card(screenWidth: screenWidth, items: podcast, colors: colors),
            const SizedBox(
              height: 30,
            ),
            const Text(
              'Browse all',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            const SizedBox(
              height: 15,
            ),
            GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Disable scrolling in GridView
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // Number of columns
              ),
              itemCount: general.length,
              itemBuilder: (context, index) {
                int randomIndex = Random().nextInt(colors.length);
                return Container(
                  width: 170,
                  height: 120,
                  decoration: BoxDecoration(
                      color: colors[randomIndex],
                      borderRadius: BorderRadius.circular(5)),
                  margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                    child: Stack(
                      children: [
                        Text(
                          general[index % general.length],
                          style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        ),
                        Positioned(
                          top: 35,
                          left: 95,
                          child: Transform.rotate(
                            angle: 0.5,
                            child: SizedBox(
                              height: 90,
                              width: 80,
                              child: Image.asset('assets/SampleImage.png'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class Card extends StatelessWidget {
  const Card({
    super.key,
    required this.screenWidth,
    required this.items,
    required this.colors,
  });

  final double screenWidth;
  final List<String> items;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      width: screenWidth,
      // decoration: BoxDecoration(color: Colors.white),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        itemBuilder: (context, index) {
          int randomIndex = Random().nextInt(colors.length);
          // print(randomIndex)
          return Container(
            width: 170,
            height: 120,
            decoration: BoxDecoration(
                color: colors[randomIndex],
                borderRadius: BorderRadius.circular(5)),
            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
              child: Stack(
                children: [
                  Text(
                    items[index % items.length],
                    style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Positioned(
                    top: 35,
                    left: 95,
                    child: Transform.rotate(
                      angle: 0.5,
                      child: SizedBox(
                        height: 80,
                        width: 80,
                        child: Image.asset('assets/SampleImage.png'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class Text_Field extends StatelessWidget {
  const Text_Field({
    super.key,
    required this.screenWidth,
  });

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: screenWidth,
      height: 45,
      child: Row(
        children: [
          SizedBox(
            height: 40,
            width: 40,
            child: Image.asset('assets/magnifyingG.png'),
          ),
          SizedBox(
            width: screenWidth - 105,
            height: 45,
            child: const TextField(
              // controller: controller,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Colors.black,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: 'Artists, songs, or podcasts',
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

class SearchText extends StatelessWidget {
  const SearchText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Search',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        SizedBox(
            height: 50, width: 50, child: Image.asset('assets/SearchCam.png')),
      ],
    );
  }
}
