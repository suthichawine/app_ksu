import 'package:app_ksu/models/announcement_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // ดึงข้อมูลประกาศ
  Stream<List<Announcement>> getAnnouncements() {
    return _db.collection('announcements')
        .orderBy('date', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Announcement.fromMap(doc.data(), doc.id))
            .toList());
  }

  // เพิ่มประกาศใหม่
  Future<void> addAnnouncement(Announcement announcement) {
    return _db.collection('announcements').add(announcement.toMap());
  }

  // ลบประกาศ
  Future<void> deleteAnnouncement(String id) {
    return _db.collection('announcements').doc(id).delete();
  }

  // แก้ไขประกาศ
  Future<void> updateAnnouncement(String id, Announcement announcement) {
    return _db.collection('announcements').doc(id).update(announcement.toMap());
  }
}
