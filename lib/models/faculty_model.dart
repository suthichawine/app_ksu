import 'dart:convert';

List<Faculty> facultyFromJson(String str) =>
    List<Faculty>.from(json.decode(str).map((x) => Faculty.fromJson(x)));

String facultyToJson(List<Faculty> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Faculty {
  String id;
  String faculty_name;
  String image;

  Faculty({
    required this.id,
    required this.faculty_name,
    required this.image,
  });

  factory Faculty.fromJson(Map<String, dynamic> json) => Faculty(
        id: json["id"],
        faculty_name: json["faculty_name"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "faculty_name": faculty_name,
        "image": image,
      };
}