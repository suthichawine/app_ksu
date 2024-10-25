import 'package:cloud_firestore/cloud_firestore.dart';

class Announcement {
  String id;
  String title;
  String content;
  DateTime createdAt;

  Announcement({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
  });

  factory Announcement.fromJson(Map<String, dynamic> json) => Announcement(
        id: json["id"] ?? '', // ถ้า id เป็น null ให้กำหนดค่าเป็น empty string
        title: json["title"] ??
            'Untitled', // ถ้า title เป็น null ให้ใช้ 'Untitled'
        content: json["content"] ??
            'No content', // ถ้า content เป็น null ให้ใช้ 'No content'
        // ตรวจสอบว่ามาจาก Firestore (Timestamp) หรือจาก String และแปลงให้เป็น DateTime
        createdAt: (json["createdAt"] as Timestamp).toDate(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "content": content,
        "createdAt": Timestamp.fromDate(
            createdAt), // แปลงกลับเป็น Firestore Timestamp เมื่อบันทึกข้อมูล
      };
}
