// To parse this JSON data, do
//
//     final courseModel = courseModelFromJson(jsonString);

import 'dart:convert';

class CourseModel {
  final String? docId;
  final String? courseName;
  final int? createdAt;

  CourseModel({
    this.docId,
    this.courseName,
    this.createdAt,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) => CourseModel(
    docId: json["docID"],
    courseName: json["courseName"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson(String courseID) => {
    "docID": courseID,
    "courseName": courseName,
    "createdAt": createdAt,
  };
}
