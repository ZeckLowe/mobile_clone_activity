import 'package:flutter/material.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Padding(
        padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
        child: Column(
          children: [
            // SizedBox(
            //   height: 75,
            // ),
            SearchText(),
            SizedBox(
              height: 10,
            ),
            Text_Field(screenWidth: screenWidth)
          ],
        ),
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
      padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
      width: screenWidth,
      height: 45,
      child: Row(
        children: [
          Container(
            height: 40,
            width: 40,
            child: Image.asset('assets/magnifyingG.png'),
          ),
          Container(
            width: screenWidth - 105,
            height: 45,
            child: TextField(
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
        Text(
          'Search',
          textAlign: TextAlign.start,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Container(
            height: 50, width: 50, child: Image.asset('assets/SearchCam.png')),
      ],
    );
  }
}
