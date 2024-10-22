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
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Center(
                  // จัดกึ่งกลางให้ข้อความ
                  // child: Text(
                  //   "มหาวิทยาลัยกาฬสินธุ์",
                  //   style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  // ),
                  ),
              const SizedBox(
                  height: 30), // เพิ่มระยะห่างระหว่างข้อความกับ Column

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
                    const SizedBox(height: 8),
                    const Text(
                      'ความรู้สร้างคุณค่า ภูมิปัญญาสร้างสังคม',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
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
                    const SizedBox(height: 8),
                    const Text(
                      'สร้างคนดี มีงานทำ ชี้นำสังคม',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(
                          Icons.public,
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
                    const SizedBox(height: 8),
                    const Text(
                      'มหาวิทยาลัยเพื่อการพัฒนาท้องถิ่น อันดับ 1 ของประเทศภายในปี 2570',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(
                          Icons.psychology,
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
                    const SizedBox(height: 8),
                    // ignore: prefer_const_constructors
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('1. ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                'ผลิตกําลังคนให้มีจิตสํานึกและความรู้ความสามารถเพื่อเป็นหลักในการขับเคลื่อนพัฒนา และเปลี่ยนแปลงในระดับพื้นที่',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8), // เพิ่มระยะห่างระหว่างบรรทัด
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('2. ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                'วิจัยและสร้างนวัตกรรมเพื่อการพัฒนาชุมชนท้องถิ่น',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('3. ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                'บริการวิชาการเพื่อยกระดับคุณภาพชีวิตให้กับชุมชนท้องถิ่น',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('4. ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                'ทํานุบํารุงศิลปวัฒนธรรมท้องถิ่นอีสาน',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        // ignore: prefer_const_constructors
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('5. ', style: TextStyle(fontSize: 16)),
                            Expanded(
                              child: Text(
                                'บริหารจัดการองค์กรให้มีสมรรถนะสูง',
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),

                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'ค่านิยม',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5), // ลดช่องว่างระหว่าง Text กับภาพ
                    Image.asset(
                      'assets/images/give.png', // เปลี่ยนพาธภาพเป็นพาธที่ถูกต้อง
                      width: 400, // กำหนดความกว้างของภาพ
                      height: 100, // กำหนดความสูงของภาพ
                      fit: BoxFit.cover, // ใช้ BoxFit.cover เพื่อให้ภาพเต็มพื้นที่
                    ),
                    const SizedBox(height: 5), // ลดช่องว่างระหว่าง Text กับภาพ
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.handshake,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'วัฒนธรรมองค์กร',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'ร่วมแรงร่วมใจ',
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.person_4_sharp,
                          color: Colors.blue,
                        ),
                        SizedBox(width: 10),
                        Text(
                          'อัตลักษณ์บัณฑิต',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const Text(
                      'อดทน สู้งาน เชี่ยวชาญวิชาชีพ',
                      style: TextStyle(
                        fontSize: 16,
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
                       