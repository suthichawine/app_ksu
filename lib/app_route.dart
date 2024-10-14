import 'package:app_ksu/components/buttoms_nav.dart';
import 'package:app_ksu/screens/admin_dashboard_screen.dart';
import 'package:app_ksu/screens/admin_login_screen.dart';
import 'package:app_ksu/screens/department_screen.dart';
import 'package:app_ksu/screens/faculty_screen.dart';
import 'package:app_ksu/screens/home_screen.dart';
import 'package:app_ksu/screens/university_screen.dart';
import 'package:app_ksu/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRouter {
  // Router Map Key
  static const String welcome = 'welcome';
  static const String university = 'university';
  static const String faculty = 'faculty';
  static const String department = 'department';
  static const String course = 'course';
  static const String home = 'home';
  static const String bottomsNav = 'bottomsNav';
  static const String adminLogin =
      'admin_login'; // เพิ่มเส้นทางสำหรับ admin login
  static const String adminDashboard =
      'admin_dashboard'; // เส้นทางสำหรับ Admin Dashboard

  // Router Map
  static Map<String, WidgetBuilder> get routes => {
        welcome: (context) => const WelcomeScreen(),
        university: (context) => UniversityScreen(),
        home: (context) => const HomeScreen(),
        bottomsNav: (context) => const BottomsNav(),
        faculty: (context) => FacultyScreen(),
        department: (context) {
          final args = ModalRoute.of(context)!.settings.arguments as String;
          return DepartmentScreen(message: args);
        },
        adminLogin: (context) =>
            const AdminLoginScreen(), // กำหนดเส้นทางสำหรับ admin login
        adminDashboard: (context) =>
            const AdminDashboardScreen(), // กำหนดเส้นทางสำหรับ Admin Dashboard
      };
}
