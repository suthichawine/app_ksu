import 'dart:convert';

class PLO {
  final String name;
  final String description;

  PLO({required this.name, required this.description});

  // ฟังก์ชันเพื่อแปลงข้อมูลเป็น Map สำหรับ Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  // ฟังก์ชันเพื่อสร้างจาก Map ที่ได้จาก Firestore
  factory PLO.fromMap(Map<String, dynamic> map) {
    return PLO(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  // ฟังก์ชันเพื่อแปลงจาก JSON เป็น PLO
  factory PLO.fromJson(String str) => PLO.fromMap(json.decode(str));

  // ฟังก์ชันเพื่อแปลงจาก PLO เป็น JSON
  String toJson() => json.encode(toMap());
}
