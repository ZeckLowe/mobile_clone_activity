import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/navigations/tabbar.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
// import 'package:mobile_clone_activity/views/search.dart';

// class SearchView2 extends StatefulWidget {
//   SearchView2({super.key});

//   @override
//   State<SearchView2> createState() => _SearchView2State();
// }

// class _SearchView2State extends State<SearchView2> {
//   static List<String> songs = [
//     "Treasure",
//     "Grenade",
//     "Just the Way You Are",
//     "Talking to the Moon",
//     "Finesse",
//     "Locked Out of Heaven",
//     "When I Was You Man",
//     "That's What I Like",
//     "Versace On The Floow",
//     "Uptown Funk",
//     "24K Magic",
//     "Marry You",
//     "The Lazy Song"
//   ];

//   List<String> display_songs = List.from(songs);

//   void updateList(String value) {
//     setState(() {
//       display_songs = songs
//           .where(
//               (element) => element.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     double screenWidth = MediaQuery.of(context).size.width;

//     return Scaffold(
//       backgroundColor: Color(0xff121212),
//       body: SingleChildScrollView(
//         padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             SearchText(),
//             SizedBox(
//               height: 10,
//             ),
//             Text_Field(
//               screenWidth: screenWidth,
//               updateList: updateList,
//             ),
//             SizedBox(
//               height: 15,
//             ),
//             Container(
//               height: 400,
//               width: 200,
//               child: ListView.builder(
//                 itemCount: display_songs.length,
//                 itemBuilder: (context, index) => ListTile(
//                   title: Text(
//                     display_songs[index],
//                     style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class Text_Field extends StatelessWidget {
//   const Text_Field({
//     super.key,
//     required this.screenWidth,
//     required this.updateList,
//   });
//   final Function updateList;
//   final double screenWidth;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//           color: Colors.white, borderRadius: BorderRadius.circular(5)),
//       padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
//       width: screenWidth,
//       height: 45,
//       child: Row(
//         children: [
//           GestureDetector(
//             onTap: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(builder: (context) => Tabbar()),
//               );
//             },
//             child: Container(
//               height: 40,
//               width: 40,
//               child: Icon(
//                 Icons.arrow_back,
//                 color: Colors.black,
//               ),
//             ),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           Container(
//             width: screenWidth - 105,
//             height: 45,
//             child: TextField(
//               onChanged: (value) => updateList(value),
//               // controller: controller,
//               style: TextStyle(
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400,
//                 color: Colors.black,
//               ),
//               decoration: InputDecoration(
//                 border: InputBorder.none,
//                 hintText: 'Search',
//                 hintStyle: TextStyle(
//                   color: Colors.black,
//                   fontSize: 15,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class SearchText extends StatelessWidget {
//   const SearchText({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         Text(
//           'Search',
//           textAlign: TextAlign.start,
//           style: TextStyle(
//             fontSize: 25,
//             fontWeight: FontWeight.bold,
//             color: Colors.white,
//           ),
//         ),
//         Container(
//             height: 50, width: 50, child: Image.asset('assets/SearchCam.png')),
//       ],
//     );
//   }
// }

class SearchView2 extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displaySongs = ref.watch(displaySongsProvider);

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        padding: EdgeInsets.fromLTRB(15, 50, 15, 15),
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
              height: 400,
              width: 200,
              child: ListView.builder(
                itemCount: displaySongs.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(
                    displaySongs[index],
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
          ],
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
    final notifier = ref.read(displaySongsProvider.notifier);

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
              notifier.reset();
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
              onChanged: (value) => notifier.updateList(value),
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
