import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_clone_activity/providers/providers.dart';
import 'package:mobile_clone_activity/views/home.dart';
import 'package:mobile_clone_activity/views/library.dart';
import 'package:mobile_clone_activity/views/profile.dart';
import 'package:mobile_clone_activity/views/search.dart';

class Tabbar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    int _selectedTab = ref.watch(selectedTabProvider);
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          onTap: (index) {
            ref.read(selectedTabProvider.notifier).state = index;
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined),
              label: "Search",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.library_music),
              label: "Your Library",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: "Profile",
            ),
          ]),
      body: Stack(
        children: [
          renderView(0, const HomeView(), _selectedTab = _selectedTab),
          renderView(1, SearchView(), _selectedTab = _selectedTab),
          renderView(2, const LibraryView(), _selectedTab = _selectedTab),
          renderView(3, const ProfileView(), _selectedTab = _selectedTab),
        ],
      ),
    );
  }

  Widget renderView(int tabIndex, Widget view, int _selectedTab) {
    return IgnorePointer(
      ignoring: _selectedTab != tabIndex,
      child: Opacity(
        opacity: _selectedTab == tabIndex ? 1 : 0,
        child: view,
      ),
    );
  }
}
