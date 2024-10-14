import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentController extends GetxController {
  var departments = <Map<String, dynamic>>[].obs; // Observable list of departments
  var isLoading = true.obs; // Observable loading state

  @override
  void onInit() {
    super.onInit();
    fetchDepartments();
  }

  Future<void> fetchDepartments() async {
    try {
      isLoading(true); // Start loading
      var fetchedDepartments = await getDepartmentsFromFirestore();
      departments.assignAll(fetchedDepartments);
    } finally {
      isLoading(false); // Stop loading
    }
  }

  // Fetch departments from Firestore
  Future<List<Map<String, dynamic>>> getDepartmentsFromFirestore() async {
    var departmentSnapshot = await FirebaseFirestore.instance.collection('department').get();
    return departmentSnapshot.docs.map((doc) {
      return doc.data(); // Return the document data directly as Map<String, dynamic>
    }).toList();
  }
}
