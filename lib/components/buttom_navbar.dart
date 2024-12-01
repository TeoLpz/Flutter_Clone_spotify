import 'package:flutter/material.dart';
import 'package:spotify/pages/home_page.dart';
import 'package:spotify/pages/search_page.dart';
// import 'package:spotify/pages/search_page.dart';
// import 'package:spotify/pages/pdf_page.dart';
// import 'package:spotify/pages/form_page.dart';

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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
        ],
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
      ),
    );
  }
}
