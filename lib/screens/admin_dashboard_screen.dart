import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatelessWidget {
  const AdminDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // ปุ่มเพิ่มประกาศ
            Card(
              child: ListTile(
                leading: const Icon(Icons.add),
                title: const Text('เพิ่ม'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
            // ปุ่มแก้ไขประกาศ
            Card(
              child: ListTile(
                leading: const Icon(Icons.edit),
                title: const Text('แก้ไข'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
            // ปุ่มลบประกาศ
            Card(
              child: ListTile(
                leading: const Icon(Icons.delete),
                title: const Text('ลบ'),
                onTap: () {
                  _showOptionDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showOptionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('เลือกการดำเนินการ'),
          content: const Text('คุณต้องการทำงานในส่วน PLO หรือ Announcement?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // ทำงานสำหรับ PLO
                _showPLOActionDialog(context);
              },
              child: const Text('PLO'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                // ทำงานสำหรับ Announcement
                _showAnnouncementActionDialog(context);
              },
              child: const Text('Announcement'),
            ),
          ],
        );
      },
    );
  }

  void _showPLOActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('PLO'),
          content: const Text('นี่คือการทำงานในส่วนของ PLO'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }

  void _showAnnouncementActionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Announcement'),
          content: const Text('นี่คือการทำงานในส่วนของ Announcement'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ตกลง'),
            ),
          ],
        );
      },
    );
  }
}
