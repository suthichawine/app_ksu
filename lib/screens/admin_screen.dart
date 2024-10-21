// import 'package:app_ksu/services/user_service.dart';
// import 'package:flutter/material.dart';

// class AdminScreen extends StatefulWidget {
//   const AdminScreen({super.key});

//   @override
//   State<AdminScreen> createState() => _AdminScreenState();
// }

// class _AdminScreenState extends State<AdminScreen> {
//   final TextEditingController _passwordController = TextEditingController();
//   final String _adminPassword = "admin123"; // รหัสผ่านที่ตั้งไว้
//   final UserService _userService = UserService();

//   Future<void> _login() async {
//     String uid = "someUID"; // UID ของผู้ใช้ (จากการ Authentication)
//     var userData = await _userService.getUserRole(uid);

//     if (userData != null && userData['role'] == 'admin') {
//       if (_passwordController.text == _adminPassword) {
//         // ignore: use_build_context_synchronously
//         Navigator.pushNamed(context, '/adminDashboard'); // ไปที่หน้า Admin
//       } else {
//         // ignore: use_build_context_synchronously
//         ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//           content: Text('รหัสผ่านไม่ถูกต้อง'),
//         ));
//       }
//     } else {
//       // ignore: use_build_context_synchronously
//       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
//         content: Text('คุณไม่มีสิทธิ์เข้าถึง'),
//       ));
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Admin Login')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           children: [
//             TextField(
//               controller: _passwordController,
//               decoration: const InputDecoration(labelText: 'รหัสผ่าน'),
//               obscureText: true,
//             ),
//             ElevatedButton(
//               onPressed: _login,
//               child: const Text('เข้าสู่ระบบ'),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
