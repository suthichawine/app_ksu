import 'dart:math';

import 'package:app_ksu/models/announcement_model.dart';
import 'package:app_ksu/services/firestore_service.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    final List<String> imagePaths = [
      'assets/images/ksu3.jpg',
      'assets/images/ksu1.jpg',
      'assets/images/ksu2.jpg',
      'assets/images/ksu7.jpg',
    ];

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppBar(
          title: const Text("ksu"),
        ),
        body: Stack(
          children: [
            // เนื้อหา HomeScreen ทั้งหมด
            Scaffold(
              body: SafeArea(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Images(imagePaths), // ส่วนของรูปภาพ
                        const SizedBox(height: 10),
                        StreamBuilder<List<Announcement>>(
                          stream: firestoreService.getAnnouncements(),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const CircularProgressIndicator();
                            }
                            if (snapshot.hasError) {
                              return const Text('Error loading announcements');
                            }
                            if (!snapshot.hasData || snapshot.data!.isEmpty) {
                              return const Text('No announcements available');
                            }

                            final random = Random(DateTime.now().day);
                            final shuffledAnnouncements = snapshot.data!
                              ..shuffle(random);
                            return Announcements(
                                shuffledAnnouncements.take(3).toList());
                          },
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget Announcements(List<Announcement> announcements) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 15, bottom: 10),
          child: Row(
            children: [
              Icon(Icons.campaign, color: Colors.blue), // ไอคอนที่ต้องการ
              SizedBox(width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
              Text(
                "Announcements",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap:
              true, // Allows ListView to be inside SingleChildScrollView
          itemCount: announcements.length,
          itemBuilder: (context, index) {
            final announcement = announcements[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10),
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // เพิ่ม Row เพื่อแสดงไอคอนและ title
                    Row(
                      children: [
                        // ไอคอน Full Coverage
                        const SizedBox(
                            width: 8), // ระยะห่างระหว่างไอคอนกับข้อความ
                        Text(
                          announcement.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),

                    // แสดงวันที่
                    Text(
                      '${announcement.date.day}-${announcement.date.month}-${announcement.date.year}',
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),

                    const SizedBox(height: 10),

                    // แสดง description ของ announcement
                    Text(
                      announcement.description,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget to display images in horizontal scroll view
  // ignore: non_constant_identifier_names
  Widget Images(List<String> imagePaths) {
    return SizedBox(
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: imagePaths.map((path) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 5.0),
              width: 350,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10.0),
                child: Image.asset(
                  path,
                  fit: BoxFit.cover,
                  width: 200,
                  height: 250,
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
