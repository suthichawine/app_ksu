import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:seniorproject/models/department_model.dart';

class DepartmentService {
  final CollectionReference department =
      FirebaseFirestore.instance.collection('department');

  Future<void> create(String facultyId, String departmentName, String imageUrl)  {
    return department.add({
      "faculty_id": facultyId,
      "department_name": departmentName,
      "image": imageUrl, // เพิ่ม field image
    });
  }
}
