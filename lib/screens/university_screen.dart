import 'package:flutter/material.dart';

class UniversityScreen extends StatelessWidget {
  const UniversityScreen({super.key});

  // Function สำหรับสร้างแต่ละ item ใน GridView
  Widget _buildGridItem(String text, String letter, Color color) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          letter,
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          text,
          style: const TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      body: SingleChildScrollView(
        // Add SingleChildScrollView to prevent overflow issues
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(
                height: 45,
                child: Text("มหาวิทยาลัยกาฬสินธุ์"),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ปรัชญา',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'ความรู้สร้างคุณค่า ภูมิปัญญาสร้างสังคม',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ปณิธาน',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'สร้างคนดี มีงานทำ ชี้นำสังคม',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'วิสัยทัศน์',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'มหาวิทยาลัยเพื่อการพัฒนาท้องถิ่น อันดับ 1 ของประเทศภายในปี 2570',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      children: [
                        Icon(
                          Icons.flag,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'พันธกิจ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    const Text(
                      'ผลิตกําลังคนให้มีจิตสํานึกและความรู้ความสามารถเพื่อเป็นหลักในการขับเคลื่อนพัฒนา และเปลี่ยนแปลงในระดับพื้นที่,\n'
                      'วิจัยและสร้างนวัตกรรมเพื่อการพัฒนาชุมชนท้องถิ่น,\n'
                      'บริการวิชาการเพื่อยกระดับคุณภาพชีวิตให้กับชุมชนท้องถิ่น,\n'
                      'ทํานุบํารุงศิลปวัฒนธรรมท้องถิ่นอีสาน,\n'
                      'บริหารจัดการองค์กรให้มีสมรรถนะสูง',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'ค่านิยม',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 200, // Set a fixed height for GridView
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 5,
                        crossAxisSpacing: 5,
                        children: <Widget>[
                          _buildGridItem('Growth', 'G', Colors.green),
                          _buildGridItem('Intention', 'I', Colors.blue),
                          _buildGridItem('Volunteer', 'V', Colors.orange),
                          _buildGridItem('Expertise', 'E', Colors.red),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
