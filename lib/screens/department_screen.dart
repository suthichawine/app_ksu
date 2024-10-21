import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/screens/plo_screen.dart';
import 'package:app_ksu/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  final String message;

  DepartmentScreen({Key? key, required this.message}) : super(key: key);

  @override
  _DepartmentScreenState createState() => _DepartmentScreenState();
}

class _DepartmentScreenState extends State<DepartmentScreen> {
  // เมธอด getFacultyName
  Future<String> getFacultyName(String facultyId) async {
    var facultyDoc = await FirebaseFirestore.instance
        .collection('faculty')
        .doc(facultyId)
        .get();

    if (facultyDoc.exists) {
      return facultyDoc[
          'faculty_name']; // assuming faculty_name is the field containing the name
    } else {
      return 'Unknown Faculty';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("สาขาวิชา"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('department')
            .where('faculty_id',
                isEqualTo: widget.message) // กรองตาม faculty_id
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasData) {
            var departments = snapshot.data!.docs;

            if (departments.isEmpty) {
              return Center(child: Text('No department found.'));
            }

            return ListView.builder(
              itemCount: departments.length,
              itemBuilder: (context, index) {
                var department = departments[index];
                var departmentName =
                    department['department_name'] ?? 'Unknown Department';
                var facultyId =
                    department['faculty_id'] ?? 'Unknown Faculty ID';

                // พิมพ์ค่าเพื่อช่วยในการดีบัก
                print(
                    "Department Name: $departmentName, Faculty ID: $facultyId");

                return FutureBuilder<String>(
                  future: getFacultyName(facultyId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // รอโหลดข้อมูล
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      String facultyName = snapshot.data!;
                      // เพิ่มการพิมพ์เพื่อช่วยในการดีบัก
                      print("Faculty Name: $facultyName");

                      return Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 5,
                        child: Container(
                          color: (index.isOdd)
                              ? _getFacultyColor(facultyName)?.withOpacity(
                                  0.8) // สีตาม faculty + ความทึบเล็กน้อย
                              : _getFacultyColor(
                                  facultyName), // สีตาม faculty โดยไม่มีการเปลี่ยนแปลง
                          child: ListTile(
                              title: Text(departmentName),
                              trailing: Icon(Icons.start_outlined),
                              onTap: () async {
                                bool isAdminLogin =
                                    SharedPrefs.getSharedPreference(
                                            'isAdmin') ??
                                        false;
                                if (isAdminLogin) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PLOScreen(
                                          departmentId: department.id),
                                    ),
                                  );
                                } else {
                                  // Navigator.pushNamed(
                                  //     context, AppRouter.);
                                }
                              }),
                        ),
                      );
                    } else {
                      return Text('Faculty name not found');
                    }
                  },
                );
              },
            );
          }

          return Center(child: Text('No departments found.'));
        },
      ),
    );
  }

  Color? _getFacultyColor(String facultyId) {
    switch (facultyId) {
      case 'คณะวิศวกรรมศาสตร์และเทคโนโลยีอุตสาหกรรม':
        return Colors.red[800];
      case 'คณะบริหารศาสตร์':
        return Colors.pink[400];
      case 'คณะเทคโนโลยีการเกษตร':
        return Colors.green[400];
      case 'คณะวิทยาศาสตร์และเทคโนโลยีสุขภาพ':
        return Colors.yellow[400];
      case 'คณะศิลปศาสตร์':
        return Colors.orange[500];
      case 'คณะศึกษาศาสตร์และนวัตกรรมการศึกษา':
        return Colors.purple[300];
      default:
        print("Unknown faculty ID: $facultyId"); // เพิ่มการพิมพ์เพื่อตรวจสอบ
        return Colors.grey[300]; // คืนค่าเป็นสีเทาอ่อนถ้าไม่พบ
    }
  }
}
