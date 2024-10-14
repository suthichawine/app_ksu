class UserService {
  // ฟังก์ชันที่จะใช้เพื่อดึงข้อมูลผู้ใช้
  Future<Map<String, dynamic>?> getUserData(String username) async {
    // ตรวจสอบและดึงข้อมูลผู้ใช้จากฐานข้อมูล
    // ตัวอย่างการใช้งาน Firestore หรือฐานข้อมูลอื่น ๆ
    // อาจจะต้องปรับให้เข้ากับโครงสร้างของฐานข้อมูลที่คุณใช้งาน

    // ตัวอย่างการจำลองข้อมูล
    if (username == 'admin') {
      return {
        'role': 'admin',
        'password': 'admin123', // รหัสผ่านที่กำหนดไว้
      };
    }
    return null; // ถ้าผู้ใช้ไม่พบ
  }
}
