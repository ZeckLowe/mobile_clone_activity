import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/providers/providers.dart';

class SearchView2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredSongs = ref.watch(filteredSongProvider);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 10, 15, 20),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SearchText(),
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
                height: screenHeight - 25,
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
          GestureDetector(
            onTap: () {
              ref.read(searchTextProvider.notifier).state = '';
              Navigator.pop(context);
              FocusScope.of(context)
                  .unfocus(); //prevent keyboard from popping up in the previous page when context is popped
            },
            child: Container(
              height: 40,
              width: 40,
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
            ),
          ),
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
                hintText: 'Search',
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
