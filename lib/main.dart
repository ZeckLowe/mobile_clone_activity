import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/navigations/tabbar.dart';
import 'package:mobile_clone_activity/views/home.dart';
import 'package:mobile_clone_activity/views/music_player.dart';
import 'package:mobile_clone_activity/views/search.dart';
import 'package:mobile_clone_activity/views/start_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          themeMode: ThemeMode.dark,
          darkTheme: ThemeData(
            scaffoldBackgroundColor: Colors.black,
            brightness: Brightness.dark,
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              backgroundColor: Colors.white10,
              type: BottomNavigationBarType.fixed,
              selectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 12,
              ),
              selectedItemColor: Colors.white,
              unselectedItemColor: Colors.white38,
            ),
          ),
          home: HomeView()),
    );
  }
}
