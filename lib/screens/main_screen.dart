import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:app_ksu/screens/home_screen.dart';
import 'package:app_ksu/screens/university_screen.dart';
import 'package:app_ksu/screens/faculty_screen.dart';
import 'package:get/get.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  // List of screens for bottom navigation
  final List<Widget> _screens = [
    const HomeScreen(),
    const UniversityScreen(),
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
      appBar: AppBar(
        title: const Text("ksu"),
        actions: [
          IconButton(
            icon: const Icon(Icons.admin_panel_settings),
            onPressed: () {
              bool isAdminLogin =
                  SharedPrefs.getSharedPreference('isAdmin') ?? false;
              if (isAdminLogin) {
                // If logged in as admin, navigate to admin dashboard
                Get.toNamed(AppRouter.adminDashboard);
              } else {
                // If not admin, navigate to login screen
                Get.toNamed(AppRouter.adminLogin);
              }
            },
          ),
        ],
      ),
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'หน้าหลัก',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label: 'มหาวิทยาลัย',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'คณะ',
          ),
        ],
      ),
    );
  }
}
