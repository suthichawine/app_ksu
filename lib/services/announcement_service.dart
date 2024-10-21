import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementService {
  final CollectionReference announcementCollection =
      FirebaseFirestore.instance.collection('Announcements');

  Future<void> addAnnouncement(String title, String description, DateTime date) async {
    try {
      // ใช้ await เพื่อรอให้การเพิ่มข้อมูลเสร็จสมบูรณ์
      await announcementCollection.add({
        'date': date,
        'description': description,
        'title': title, // แก้ไขให้ถูกต้องโดยลบช่องว่างหลัง 'title'
      });
      print("Announcement added successfully");
    } catch (error) {
      print("Failed to add announcement: $error");
      // คุณอาจต้องการจัดการข้อผิดพลาดเพิ่มเติมที่นี่
    }
  }

  Future<void> updateAnnouncement(String id, String title, String description, DateTime date) async {
    return await announcementCollection.doc(id).update({
      'title': title,
      'description': description,
      'date': date,
    });
  }

  Future<void> deleteAnnouncement(String id) async {
    return await announcementCollection.doc(id).delete();
  }
}
