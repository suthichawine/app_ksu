import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/utils/utils.dart';
import 'package:flutter/material.dart';

class AdminLoginScreen extends StatefulWidget {
  const AdminLoginScreen({super.key});

  @override
  State<AdminLoginScreen> createState() => _AdminLoginScreenState();
}

class _AdminLoginScreenState extends State<AdminLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  // final UserService _userService = UserService(); // บริการดึงข้อมูลผู้ใช้

  Future<void> _login() async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    if (username.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('กรุณากรอกชื่อผู้ใช้และรหัสผ่าน'),
      ));
      return;
    }
    await SharedPrefs.setSharedPreference('isAdmin', true);
    Navigator.pushNamed(context, AppRouter.adminDashboard);

    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Admin Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _usernameController,
              decoration:
                  const InputDecoration(labelText: 'ชื่อผู้ใช้ (อีเมล)'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: const Text('เข้าสู่ระบบ'),
            ),
          ],
        ),
      ),
    );
  }
}
