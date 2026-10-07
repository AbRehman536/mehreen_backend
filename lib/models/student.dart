// To parse this JSON data, do
//
//     final studentModel = studentModelFromJson(jsonString);

import 'dart:convert';

class StudentModel {
  final String? docId;
  final String? name;
  final int? age;
  final String? city;
  final bool? isPassed;
  final int? createdAt;

  StudentModel({
    this.docId,
    this.name,
    this.age,
    this.city,
    this.isPassed,
    this.createdAt,
  });

  factory StudentModel.fromJson(Map<String, dynamic> json) => StudentModel(
    docId: json["docID"],
    name: json["name"],
    age: json["age"],
    city: json["city"],
    isPassed: json["isPassed"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String studentID) => {
    "docID": studentID,
    "name": name,
    "age": age,
    "city": city,
    "isPassed": isPassed,
    "createdAt": createdAt,
  };
}
