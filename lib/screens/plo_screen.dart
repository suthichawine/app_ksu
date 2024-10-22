import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PLOScreen extends StatefulWidget {
  final String departmentId;

  const PLOScreen({Key? key, required this.departmentId}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _PLOScreenState createState() => _PLOScreenState();
}

class _PLOScreenState extends State<PLOScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLOs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
          ),
          Expanded(
            child: StreamBuilder<DocumentSnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('department')
                  .doc(widget.departmentId)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data != null) {
                  // แปลง document.data() ให้เป็น Map<String, dynamic>
                  var documentData =
                      snapshot.data!.data() as Map<String, dynamic>?;

                  // รับข้อมูล plos ถ้ามี ถ้าไม่มีให้เป็น null
                  List<dynamic>? plos = documentData?['plos'];

                  // ถ้าไม่มีข้อมูลให้แสดงหน้าว่าง
                  if (plos == null || plos.isEmpty) {
                    return SizedBox
                        .shrink(); // หน้าจอว่างเปล่า (ไม่แสดงอะไรเลย)
                  }

                  // แสดงผล PLOs ถ้ามีข้อมูล
                  return ListView.builder(
                    itemCount: plos.length,
                    itemBuilder: (context, index) {
                      var plo = plos[index] as Map<String, dynamic>;
                      var ploText =
                          plo['PLO'] ?? 'No PLO description available';

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0), // เพิ่ม padding ในแกน Y
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          elevation: 5,
                          child: ListTile(
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10.0,
                                horizontal:
                                    16.0), // ปรับ padding ภายใน ListTile
                            title: Text(
                              ploText,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            leading: Icon(Icons.school, color: Colors.blue),
                          ),
                        ),
                      );
                    },
                  );
                } else {
                  return SizedBox.shrink(); // หน้าจอว่างเปล่า (ไม่แสดงอะไรเลย)
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
