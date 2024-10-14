// import จำเป็น
import 'package:app_ksu/models/plo_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PLOService {
  // ฟังก์ชันเพื่อเพิ่มข้อมูล PLO เข้าไปใน Firestore
  Future<void> addPLOToFirestore(PLO plo) async {
    try {
      // อ้างอิงไปยัง collection 'plos'
      CollectionReference plos = FirebaseFirestore.instance.collection('plos');

      // เพิ่มข้อมูล PLO โดยใช้ toMap()
      await plos.add(plo.toMap());

      print("PLO added successfully!");
    } catch (e) {
      print("Failed to add PLO: $e");
    }
  }
}
