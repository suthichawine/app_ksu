import 'package:app_ksu/models/plo_model.dart';
import 'package:app_ksu/services/department_service.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  final String departmentId;

  const CourseScreen({super.key, required this.departmentId});

  @override
  Widget build(BuildContext context) {
    final departmentService = DepartmentService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Program Learning Outcomes'),
      ),
      body: FutureBuilder<List<PLO>>(
        future: departmentService.getPLOs(departmentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final plos = snapshot.data!;
            return ListView.builder(
              itemCount: plos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(plos[index].name),
                  subtitle: Text(plos[index].description),
                );
              },
            );
          } else {
            return const Center(child: Text('No PLOs found'));
          }
        },
      ),
    );
  }
}
