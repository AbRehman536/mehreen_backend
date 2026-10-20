// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
  final String? docId;
  final String? userName;
  final String? email;
  final String? phone;
  final String? address;
  final int? createdAt;

  UserModel({
    this.docId,
    this.userName,
    this.email,
    this.phone,
    this.address,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    docId: json["docID"],
    userName: json["userName"],
    email: json["email"],
    phone: json["phone"],
    address: json["address"],
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "docID": docId,
    "userName": userName,
    "email": email,
    "phone": phone,
    "address": address,
    "createdAt": createdAt,
  };
}
