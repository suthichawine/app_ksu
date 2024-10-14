// To parse this JSON data, do
//
//     final department = departmentFromJson(jsonString);

import 'dart:convert';

Department departmentFromJson(String str) => Department.fromJson(json.decode(str));

String departmentToJson(Department data) => json.encode(data.toJson());

class Department {
    String id;
    String departmentName;
    String facultyId;
    List<Plo> plos;

    Department({
        required this.id,
        required this.departmentName,
        required this.facultyId,
        required this.plos,
    });

    factory Department.fromJson(Map<String, dynamic> json) => Department(
        id: json["id"],
        departmentName: json["department_name"],
        facultyId: json["faculty_id"],
        plos: List<Plo>.from(json["plos"].map((x) => Plo.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "faculty_id": facultyId,
        "plos": List<dynamic>.from(plos.map((x) => x.toJson())),
    };
}

class Plo {
    String plo;

    Plo({
        required this.plo,
    });

    factory Plo.fromJson(Map<String, dynamic> json) => Plo(
        plo: json["PLO"],
    );

    Map<String, dynamic> toJson() => {
        "PLO": plo,
    };
}
