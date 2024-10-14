import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> createUser(
      String uid, String email, String name, String role) async {
    try {
      await firestore.collection('users').doc(uid).set({
        'email': email,
        'name': name,
        'role': role,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('User created successfully');
    } catch (e) {
      print('Failed to create user: $e');
    }
  }
}
