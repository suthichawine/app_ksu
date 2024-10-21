import 'package:app_ksu/components/buttoms_nav.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Firestore Service for Announcement operations
class FirestoreService {
  final CollectionReference announcementCollection =
      FirebaseFirestore.instance.collection('Announcements');

  Future<void> addAnnouncement(
      String title, String description, DateTime date) async {
    return await announcementCollection.add({
      'title': title,
      'description': description,
      'date': date,
    }).then((value) {
      print("Announcement added successfully");
    }).catchError((error) {
      print("Failed to add announcement: $error");
    });
  }

  Future<void> updateAnnouncement(String announcementId, String title,
      String description, DateTime date) async {
    return await announcementCollection
        .doc(announcementId)
        .update({
          'title': title,
          'description': description,
          'date': date,
        })
        .then((value) => print("Announcement updated"))
        .catchError((error) => print("Failed to update: $error"));
  }

  Future<void> deleteAnnouncement(String announcementId) async {
    return await announcementCollection
        .doc(announcementId)
        .delete()
        .then((value) => print("Announcement deleted"))
        .catchError((error) => print("Failed to delete: $error"));
  }
}

// Main Admin Dashboard Screen
class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({Key? key}) : super(key: key);

  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  // Firestore service and controllers
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Navigate back to BottomsNav when back is pressed
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => BottomsNav()),
          (Route<dynamic> route) => false,
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Admin Dashboard'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Add Announcement button
              Card(
                child: ListTile(
                  leading: const Icon(Icons.add),
                  title: const Text('เพิ่มประกาศ'),
                  onTap: () {
                    // Show the add announcement dialog
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AnnouncementWidget(),
                      ),
                    );
                  },
                ),
              ),
              // Edit Announcement button
              Card(
                child: ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text('แก้ไขประกาศ'),
                  onTap: () {
                    _showOptionDialog(context, isEditing: true);
                  },
                ),
              ),
              // Delete Announcement button
              Card(
                child: ListTile(
                  leading: const Icon(Icons.delete),
                  title: const Text('ลบประกาศ'),
                  onTap: () {
                    _showOptionDialog(context, isDeleting: true);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Show option dialog for edit or delete announcement
  void _showOptionDialog(BuildContext context,
      {bool isEditing = false, bool isDeleting = false}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(isEditing
              ? 'เลือกประกาศที่จะแก้ไข'
              : isDeleting
                  ? 'เลือกประกาศที่จะลบ'
                  : 'เลือกการดำเนินการ'),
          content: const Text('กรุณาเลือกการดำเนินการ'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }
}

// AnnouncementWidget for Add, Edit, Delete
class AnnouncementWidget extends StatelessWidget {
  final FirestoreService announcementService = FirestoreService();
  final String? announcementId;

  AnnouncementWidget({this.announcementId});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(announcementId == null ? 'เพิ่มประกาศ' : 'แก้ไขประกาศ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'ชื่อประกาศ'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'รายละเอียดประกาศ'),
            ),
            TextField(
              decoration: const InputDecoration(labelText: 'วันที่'),
              readOnly: true,
              onTap: () async {
                selectedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2101),
                );
              },
            ),
            ElevatedButton(
              onPressed: () async {
                if (announcementId != null) {
                  // Edit announcement
                  await announcementService.updateAnnouncement(
                    announcementId!,
                    titleController.text,
                    descriptionController.text,
                    selectedDate ?? DateTime.now(),
                  );
                } else {
                  // Add announcement
                  await announcementService.addAnnouncement(
                    titleController.text,
                    descriptionController.text,
                    selectedDate ?? DateTime.now(),
                  );
                }
                Navigator.pop(context); // Go back after the operation
              },
              child:
                  Text(announcementId == null ? 'เพิ่มประกาศ' : 'แก้ไขประกาศ'),
            ),
            if (announcementId != null)
              ElevatedButton(
                onPressed: () async {
                  // Delete announcement
                  await announcementService.deleteAnnouncement(announcementId!);
                  Navigator.pop(context); // Go back after deletion
                },
                child: const Text('ลบประกาศ'),
              ),
          ],
        ),
      ),
    );
  }
}
