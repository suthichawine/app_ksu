import 'package:cloud_firestore/cloud_firestore.dart';

class CourseService {

  final CollectionReference  course = FirebaseFirestore.instance.collection('course');

  Future<void> create() {
    return course.add({
      "message": "hello world"
    });
    // return;
  }
}
