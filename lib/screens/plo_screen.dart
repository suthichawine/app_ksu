import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PLOScreen extends StatefulWidget {
  final String departmentId;

  PLOScreen({Key? key, required this.departmentId}) : super(key: key);

  @override
  _PLOScreenState createState() => _PLOScreenState();
}

class _PLOScreenState extends State<PLOScreen> {
  final TextEditingController _controllerPLO = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PLOs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            // child: TextField(
            //   controller: _controllerPLO,
            //   decoration: InputDecoration(labelText: 'Enter PLO'),
            // ),
          ),
          // ElevatedButton(
          //   onPressed: () {
          //     if (_controllerPLO.text.isNotEmpty) {
          //       FirebaseFirestore.instance
          //           .collection('department')
          //           .doc(widget.departmentId)
          //           .update({
          //         'plos': FieldValue.arrayUnion([
          //           {'PLO': _controllerPLO.text}
          //         ]),
          //       });
          //       _controllerPLO.clear();
          //     }
          //   },
          //   // child: Text('Add PLO'),
          // ),
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

                      return ListTile(
                        title: Text(ploText),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
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

  void _deletePLO(String ploText) {
    FirebaseFirestore.instance
        .collection('department')
        .doc(widget.departmentId)
        .update({
      'plos': FieldValue.arrayRemove([
        {'PLO': ploText}
      ]),
    });
  }

  void _showEditDialog(String oldPLO, int index) {
    TextEditingController _editController = TextEditingController(text: oldPLO);

    // showDialog(
    // context: context,
    // builder: (context) {
    // return AlertDialog(
    //   title: Text('Edit PLO'),
    //   content: TextField(
    //     controller: _editController,
    //     decoration: InputDecoration(labelText: 'PLO'),
    //   ),
    //   actions: [
    //     ElevatedButton(
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //         _updatePLO(oldPLO, _editController.text);
    //       },
    //       child: Text('Update'),
    //     ),
    //   ],
    // );
    // },
    // );
  }

  void _updatePLO(String oldPLO, String newPLO) {
    if (newPLO.isNotEmpty) {
      FirebaseFirestore.instance
          .collection('department')
          .doc(widget.departmentId)
          .update({
        'plos': FieldValue.arrayRemove([
          {'PLO': oldPLO}
        ]),
      });

      FirebaseFirestore.instance
          .collection('department')
          .doc(widget.departmentId)
          .update({
        'plos': FieldValue.arrayUnion([
          {'PLO': newPLO}
        ]),
      });
    }
  }
}
