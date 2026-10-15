// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

class StudentModel {
  final String? docId;
  final String? courseID;
  final String? name;
  final int? age;
  final String? city;
  final bool? isPassed;
  final List<dynamic>? saved;
  final int? createdAt;

  StudentModel({
    this.docId,
    this.courseID,
    this.name,
    this.age,
    this.city,
    this.isPassed,
    this.saved,
    this.createdAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    docId: json["docID"],
    courseID: json["courseID"],
    name: json["name"],
    age: json["age"],
    city: json["city"],
    isPassed: json["isPassed"],
    saved: json["saved"] == null ? [] : List<dynamic>.from(json["saved"]!.map((x) => x)),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String studentID) => {
    "docID": studentID,
    "courseID": courseID,
    "name": name,
    "age": age,
    "city": city,
    "isPassed": isPassed,
    "saved": saved == null ? [] : List<dynamic>.from(saved!.map((x) => x)),
    "createdAt": createdAt,
  };
}
