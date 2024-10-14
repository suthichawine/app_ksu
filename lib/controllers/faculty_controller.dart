import 'package:app_ksu/models/faculty_model.dart';
import 'package:app_ksu/services/faculty_service.dart';
import 'package:get/get.dart';

class FacultyController extends GetxController {
  var faculties = <Faculty>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchFaculties();
  }

  Future<void> fetchFaculties() async {
    try {
      isLoading(true);
      // await Future.delayed(const Duration(seconds: 3));
      var fetchedFaculties = await FacultyService().getAllFaculties();
      faculties.assignAll(fetchedFaculties);
    } finally {
      isLoading(false);
    }
  }
}
