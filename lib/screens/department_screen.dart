// import 'package:flutter/material.dart';

// class DepartmentScreen extends StatefulWidget {
//   final String message;

//   DepartmentScreen({Key? key, required this.message}) : super(key: key);

//   @override
//   _DepartmentScreenState createState() => _DepartmentScreenState();
// }

// class _DepartmentScreenState extends State<DepartmentScreen> {
//   @override
//   Widget build(BuildContext context) {
// return Container();
// return Scaffold(
//   appBar: AppBar(
//     title: Text(widget.message),
//   ),
//   body: StreamBuilder<QuerySnapshot>(
//     stream: FirebaseFirestore.instance.collection('department').snapshots(),
//     builder: (context, snapshot) {
//       if (snapshot.hasError) {
//         return Center(child: Text('Error: ${snapshot.error}'));
//       }
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       }

//       if (snapshot.hasData) {
//         var departments = snapshot.data!.docs;

//         if (departments.isEmpty) {
//           return Center(child: Text('No department found.'));
//         }

//         return ListView.builder(
//           itemCount: departments.length,
//           itemBuilder: (context, index) {
//             var department = departments[index];
//             var departmentName = department['department_name'] ?? 'Unknown Department';

//             return Card(
//               margin: EdgeInsets.all(8.0),
//               elevation: 4,
//               child: ListTile(
//                 title: Text(departmentName),
//                 subtitle: Text('Faculty ID: ${department['faculty_id']}'),
//                 trailing: Icon(Icons.arrow_forward),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => PLOScreen(departmentId: department.id),
//                     ),
//                   );
//                 },
//               ),
//             );
//           },
//         );
//       }

//       return Center(child: Text('No departments found.'));
//     },
//   ),
// );
// }
// }

// class PLOScreen extends StatefulWidget {
//   final String departmentId;

//   PLOScreen({Key? key, required this.departmentId}) : super(key: key);

//   @override
//   _PLOScreenState createState() => _PLOScreenState();
// }

// class _PLOScreenState extends State<PLOScreen> {
//   final TextEditingController _controllerPLO = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('PLOs'),
//       ),
//       body: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: TextField(
//               controller: _controllerPLO,
//               decoration: InputDecoration(labelText: 'Enter PLO'),
//             ),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               if (_controllerPLO.text.isNotEmpty) {
//                 FirebaseFirestore.instance
//                     .collection('department')
//                     .doc(widget.departmentId)
//                     .update({
//                   'plos': FieldValue.arrayUnion([
//                     {'PLO': _controllerPLO.text}
//                   ]),
//                 });
//                 _controllerPLO.clear();
//               }
//             },
//             child: Text('Add PLO'),
//           ),
//           Expanded(
//             child: StreamBuilder<DocumentSnapshot>(
//               stream: FirebaseFirestore.instance
//                   .collection('department')
//                   .doc(widget.departmentId)
//                   .snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.hasError) {
//                   return Center(child: Text('Error: ${snapshot.error}'));
//                 }
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasData && snapshot.data != null) {
//                   var document = snapshot.data!;
//                   var plos = document.get('plos') as List<dynamic>?;

//                   if (plos == null || plos.isEmpty) {
//                     return Center(child: Text('No PLO data found.'));
//                   }

//                   return ListView.builder(
//                     itemCount: plos.length,
//                     itemBuilder: (context, index) {
//                       var plo = plos[index] as Map<String, dynamic>;
//                       var ploText =
//                           plo['PLO'] ?? 'No PLO description available';

//                       return ListTile(
//                         title: Text(ploText),
//                         trailing: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             IconButton(
//                               icon: Icon(Icons.edit),
//                               onPressed: () {
//                                 _showEditDialog(ploText, index);
//                               },
//                             ),
//                             IconButton(
//                               icon: Icon(Icons.delete),
//                               onPressed: () {
//                                 _deletePLO(ploText);
//                               },
//                             ),
//                           ],
//                         ),
//                       );
//                     },
//                   );
//                 } else {
//                   return Center(child: Text('No PLO data found.'));
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   void _deletePLO(String ploText) {
//     FirebaseFirestore.instance
//         .collection('department')
//         .doc(widget.departmentId)
//         .update({
//       'plos': FieldValue.arrayRemove([
//         {'PLO': ploText}
//       ]),
//     });
//   }

//   void _showEditDialog(String oldPLO, int index) {
//     TextEditingController _editController = TextEditingController(text: oldPLO);

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Edit PLO'),
//           content: TextField(
//             controller: _editController,
//             decoration: InputDecoration(labelText: 'PLO'),
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 _updatePLO(oldPLO, _editController.text);
//               },
//               child: Text('Update'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _updatePLO(String oldPLO, String newPLO) {
//     if (newPLO.isNotEmpty) {
//       FirebaseFirestore.instance
//           .collection('department')
//           .doc(widget.departmentId)
//           .update({
//         'plos': FieldValue.arrayRemove([
//           {'PLO': oldPLO}
//         ]),
//       });

//       FirebaseFirestore.instance
//           .collection('department')
//           .doc(widget.departmentId)
//           .update({
//         'plos': FieldValue.arrayUnion([
//           {'PLO': newPLO}
//         ]),
//       });
//     }
//   }
// }

import 'package:app_ksu/screens/plo_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  final String message;

  const DepartmentScreen({super.key, required this.message});
  @override
  State<DepartmentScreen> createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.message),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('department').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var departments = snapshot.data!.docs;

            if (departments.isEmpty) {
              return const Center(child: Text('No department found.'));
            }

            return ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, index) {
                var department = departments[index];
                var departmentName =
                    department['department_name'] ?? 'Unknown Department';

                return Card(
                  margin: const EdgeInsets.all(8.0),
                  elevation: 4,
                  child: ListTile(
                    title: Text(departmentName),
                    subtitle: Text('Faculty ID: ${department['faculty_id']}'),
                    trailing: const Icon(Icons.arrow_forward),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              PloScreen(departmentId: department.id),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          }

          return const Center(child: Text('No departments found.'));
        },
      ),
    );
  }
}
