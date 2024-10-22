import 'package:app_ksu/screens/plo_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DepartmentScreen extends StatefulWidget {
  final String message;
  final String departmentName;

  const DepartmentScreen({
    super.key,
    required this.message,
    required this.departmentName,
  });

  @override
  // ignore: library_private_types_in_public_api
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

  var iconName = 'devices';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.departmentName),
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

                // พิมพ์ชื่อ departmentName ออกมาเพื่อตรวจสอบ
                print('Department Name: $departmentName');

                return FutureBuilder<String>(
                  future: getFacultyName(facultyId),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // รอโหลดข้อมูล
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      String facultyName = snapshot.data!;

                      return Card(
                        margin: EdgeInsets.all(10.0),
                        elevation: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: _getFacultyColor(facultyName) ??
                                  Colors.grey[300]!,
                              width: 1.0, // ความหนาของเส้นขอบ
                            ),
                            borderRadius:
                                BorderRadius.circular(10.0), // ปรับขอบให้โค้งมน
                          ),
                          child: ListTile(
                            leading: Icon(Icons.devices, // แสดงไอคอนตามสาขา
                              color: Colors.amber,
                            ),
                            title: Text(departmentName),
                            trailing: Icon(Icons.arrow_forward_ios),
                            onTap: () {
                              // พาไปที่หน้า PLOScreen เมื่อกดไอคอน
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PLOScreen(
                                    departmentId: department.id,
                                  ),
                                ),
                              );
                            },
                          ),
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

  // ฟังก์ชันสำหรับเลือกไอคอนตามชื่อสาขา
  IconData _getDepartmentIcon(String departmentName) {
    switch (departmentName) {
      case 'สาขาวิชาคอมพิวเตอร์ธุรกิจ':
        return Icons.computer; // ใช้ไอคอนคอมพิวเตอร์
      case 'สาขาวิชาเคมีภัณฑ์และจุลชีววิทยาอุตสาหกรรม':
        return Icons.science; // ใช้ไอคอนวิทยาศาสตร์
      case 'สาขาวิชาวิศวกรรมอุตสาหการ':
        return Icons.engineering; // ใช้ไอคอนวิศวกรรม
      case 'สาขาวิชานวัตกรรมธุรกิจการค้าสมัยใหม่':
        return Icons.business; // ใช้ไอคอนธุรกิจ
      case 'สาขาวิชาเอกคอมพิวเตอร์':
        return Icons.laptop; // ใช้ไอคอนแล็ปท็อป
      // เพิ่มเคสอื่นๆ สำหรับสาขาวิชาอื่นๆ ที่คุณมี
      default:
        return Icons.account_balance; // ใช้ไอคอนทั่วไปถ้าไม่พบ
    }
  }

  // ฟังก์ชันสำหรับเลือกสีตามคณะ
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
