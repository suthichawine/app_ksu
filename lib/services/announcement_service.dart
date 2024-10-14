import 'package:cloud_firestore/cloud_firestore.dart';

class AnnouncementService {
  final CollectionReference announcementCollection = FirebaseFirestore.instance.collection('Announcements');

  Future<void> addAnnouncement(String title, String description, DateTime date) async {
    try {
      await announcementCollection.add({
        'title': title,
        'description': description,
        'date': date,
      });
    } catch (e) {
      print("Failed to add announcement: $e");
    }
  }
}
