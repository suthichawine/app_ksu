import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PLOScreen extends StatefulWidget {
  final String departmentId;

  const PLOScreen({Key? key, required this.departmentId}) : super(key: key);

  @override
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
                  var documentData = snapshot.data!.data() as Map<String, dynamic>?;
                  List<dynamic>? plos = documentData?['plos'];
                  String? assetImagePath = documentData?['imagePath']; // ดึง path ของ asset

                  return Column(
                    children: [
                      if (assetImagePath != null)
                        Image.asset("assets/images/coms.jpeg"), // แสดงรูปภาพจาก asset
                      Expanded(
                        child: ListView.builder(
                          itemCount: plos?.length ?? 0,
                          itemBuilder: (context, index) {
                            var plo = plos![index] as Map<String, dynamic>;
                            var ploText = plo['PLO'] ?? 'No PLO description available';

                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                ),
                                elevation: 5,
                                child: ListTile(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
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
                        ),
                      ),
                    ],
                  );
                } else {
                  return SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
