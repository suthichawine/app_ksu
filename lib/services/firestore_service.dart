import 'package:app_ksu/models/announcement_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String collection = 'announcements';

  // ฟังก์ชันดึงข้อมูลทั้งหมดจาก Firestore
  Stream<List<Announcement>> getAnnouncements() {
    return _db
        .collection(collection)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) =>
                Announcement.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  // ฟังก์ชันดึงข้อมูลเพียงครั้งเดียว (ไม่ใช้ Stream)
  Future<List<Announcement>> getAnnouncementsOnce() async {
    var snapshot = await _db
        .collection(collection)
        .orderBy('createdAt', descending: true)
        .get();
    return snapshot.docs
        .map((doc) => Announcement.fromJson(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
