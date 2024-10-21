import 'package:app_ksu/app_route.dart';
import 'package:app_ksu/controllers/faculty_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class FacultyScreen extends StatelessWidget {
  // Example list of faculties with image paths
  final FacultyController facultyController = Get.put(FacultyController());

  FacultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // ตั้งค่าจำนวนคอลัมน์เป็น 2
            mainAxisSpacing: 10.0, // ตั้งค่าช่องว่างระหว่างแถว
            crossAxisSpacing: 10.0, // ตั้งค่าช่องว่างระหว่างคอลัมน์
            childAspectRatio: 1.0, // ตั้งค่าอัตราส่วนของ item
          ),
          itemCount: facultyController.faculties.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(0),
              child: InkWell(
                onTap: () {
                  // print('Card ${faculties[index]['title']} was tapped!');
                  // final FacultyService facultyService = FacultyService();
                  // facultyService.create(faculties[index]["title"].toString());
                  Navigator.pushNamed(
                    context,
                    AppRouter.department,
                    arguments: facultyController.faculties[index].id,
                  );
                },
                child: Card(
                  color: Colors.lightBlue[40], // ตั้งค่าสีของ card
                  shadowColor: Colors.black87, // ตั้งค่าสีเงา
                  elevation: 3, // ตั้งค่า elevation
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        facultyController.faculties[index].image,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                          height: 10), // เพิ่มระยะห่างระหว่าง image และ text
                      Text(
                        facultyController.faculties[index].faculty_name,
                        textAlign:
                            TextAlign.center, // ตั้งค่าให้ title อยู่ตรงกลาง
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}