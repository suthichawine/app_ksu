import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PloScreen extends StatefulWidget {
  final String departmentId;

  const PloScreen({super.key, required this.departmentId});

  @override
  State<PloScreen> createState() => _PloScreenState();
}

class _PloScreenState extends State<PloScreen> {
  final TextEditingController _controllerPLO = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PLOs'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _controllerPLO,
              decoration: const InputDecoration(labelText: 'Enter PLO'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controllerPLO.text.isNotEmpty) {
                FirebaseFirestore.instance
                    .collection('department')
                    .doc(widget.departmentId)
                    .update({
                  'plos': FieldValue.arrayUnion([
                    {'PLO': _controllerPLO.text}
                  ]),
                });
                _controllerPLO.clear();
              }
            },
            child: const Text('Add PLO'),
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
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasData && snapshot.data != null) {
                  var document = snapshot.data!;
                  var plos = document.get('plos') as List<dynamic>?;

                  if (plos == null || plos.isEmpty) {
                    return const Center(child: Text('No PLO data found.'));
                  }

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
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () {
                                _showEditDialog(ploText, index);
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                _deletePLO(ploText);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(child: Text('No PLO data found.'));
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
    TextEditingController editController = TextEditingController(text: oldPLO);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit PLO'),
          content: TextField(
            controller: editController,
            decoration: const InputDecoration(labelText: 'PLO'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                _updatePLO(oldPLO, editController.text);
              },
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
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
