import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/firebase_options.dart';
import 'package:app_ksu/themes/colors.dart';
import 'package:app_ksu/utils/utils.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

var initialRoute;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Initialize Shared Preferences
  await SharedPrefs.initSharedPrefs();

  // Check if it's the first time user opens the app
  bool isFirstTime = SharedPrefs.getSharedPreference('isFirstTime') ?? true;

  // Get the user's role from Shared Preferences
  String? userRole = SharedPrefs.getSharedPreference('user_role');

  if (isFirstTime) {
    initialRoute = AppRouter.welcome; // นำทางไปหน้าต้อนรับถ้าเป็นครั้งแรก
  } else {
    if (userRole == 'admin') {
      initialRoute = AppRouter.adminLogin; // นำทางไปหน้า Admin
    } else {
      initialRoute = AppRouter.bottomsNav; // นำทางไปหน้า Home สำหรับผู้ใช้ทั่วไป
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routes: AppRouter.routes,
      initialRoute: initialRoute,
    );
  }
}
