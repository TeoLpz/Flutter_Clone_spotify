import 'package:flutter/material.dart';
import 'package:spotify/pages/home_page.dart';
import 'package:spotify/pages/search_page.dart';
import 'package:spotify/pages/pdf_pages/pdf_list_page.dart';
import 'package:spotify/pages/playlist_page.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomNavbar(); // Botón de navegación está presente en todas las pantallas
  }
}

class BottomNavbar extends StatefulWidget {
  @override
  _BottomNavbarState createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
    PlaylistListPage(),
    PdfListPage(),
  ];

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: 'Playlist',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.picture_as_pdf),
            label: 'Lector',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: const Color.fromARGB(255, 226, 226, 226),
        showUnselectedLabels: true,
        backgroundColor: const Color.fromARGB(255, 32, 32, 32),
      ),
    );
  }
}
