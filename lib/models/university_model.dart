// To parse this JSON data, do
//
//     final univers = universFromJson(jsonString);

import 'dart:convert';

Univers universFromJson(String str) => Univers.fromJson(json.decode(str));

String universToJson(Univers data) => json.encode(data.toJson());

class Univers {
    String vision;
    String philosophy;
    List<Mission> mission;

    Univers({
        required this.vision,
        required this.philosophy,
        required this.mission,
    });

    factory Univers.fromJson(Map<String, dynamic> json) => Univers(
        vision: json["vision"],
        philosophy: json["philosophy"],
        mission: List<Mission>.from(json["Mission"].map((x) => Mission.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "vision": vision,
        "philosophy": philosophy,
        "Mission": List<dynamic>.from(mission.map((x) => x.toJson())),
    };
}

class Mission {
    String m;

    Mission({
        required this.m,
    });

    factory Mission.fromJson(Map<String, dynamic> json) => Mission(
        m: json["m"],
    );

    Map<String, dynamic> toJson() => {
        "m": m,
    };
}
