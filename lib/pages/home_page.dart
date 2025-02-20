import 'package:flutter/material.dart';
import 'package:flutter_camping_frontend/pages/beranda_page.dart';
import 'package:flutter_camping_frontend/pages/bookmark_page.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    BerandaPage(),
    BookmarkPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
          child: GNav(
            color: Color(0xFFBFBFBF),
            activeColor: Colors.white,
            tabBackgroundColor: Color(0xFF274F66),
            gap: 4,
            padding: EdgeInsets.all(12),
            tabs: [
              GButton(icon: Icons.home, text: 'Beranda'),
              GButton(icon: Icons.bookmark, text: 'Bookmark'),
              GButton(icon: Icons.thumb_up_sharp, text: 'Rekomendasi'),
              GButton(icon: Icons.person, text: 'Profile'),
            ],
          ),
        ),
      ),
    );
  }
}
