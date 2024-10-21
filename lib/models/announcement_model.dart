import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String title;
  String description;
  DateTime date;

  Announcement({
    required this.title,
    required this.description,
    required this.date,
  });

  // แปลงข้อมูลจาก Map เป็น Announcement object
  factory Announcement.fromMap(Map<String, dynamic> data) {
    return Announcement(
      title: data['title'],
      description: data['description'],
      date: (data['date'] as Timestamp).toDate(), // Firestore stores date as Timestamp
    );
  }

  // แปลง Announcement object เป็น Map เพื่อบันทึกใน Firestore
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date,
    };
  }
}
