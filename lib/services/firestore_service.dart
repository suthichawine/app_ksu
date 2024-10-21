import 'package:app_ksu/models/announcement_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final collection = 'Announcements';

  // ดึงข้อมูลประกาศ
  Stream<List<Announcement>> getAnnouncements() {
    return _db.collection(collection).snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        print('Announcement data: ${doc.data()}');
        return Announcement.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  // เพิ่มประกาศใหม่
  Future<void> addAnnouncement(Announcement announcement) {
    return _db.collection(collection).add(announcement.toMap());
  }

  // ลบประกาศ
  Future<void> deleteAnnouncement(String id) {
    return _db.collection(collection).doc(id).delete();
  }

  // แก้ไขประกาศ
  Future<void> updateAnnouncement(String id, Announcement announcement) {
    return _db.collection(collection).doc(id).update(announcement.toMap());
  }
}
