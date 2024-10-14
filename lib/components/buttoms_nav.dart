import 'package:app_ksu/screens/faculty_screen.dart';
import 'package:app_ksu/screens/home_screen.dart';
import 'package:app_ksu/screens/university_screen.dart';
import 'package:flutter/material.dart';

class BottomsNav extends StatefulWidget {
  const BottomsNav({super.key});

  @override
  State<BottomsNav> createState() => _BottomsNavState();
}

class _BottomsNavState extends State<BottomsNav> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const UniversityScreen(),
    const HomeScreen(),
    FacultyScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: 'มหาวิทยาลัย',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'คณะ',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
