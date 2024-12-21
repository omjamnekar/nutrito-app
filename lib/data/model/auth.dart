import 'dart:ui';

import 'package:uuid/uuid.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;

  UserModel({
    String? id,
    this.name,
    this.email,
    this.password,
    this.phone,
    this.image,
  }) : id = id ?? Uuid().v1() ?? "";

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? "",
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      password: json['password'] ?? "",
      phone: json['phone'] ?? "",
      image: json['image'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
      'image': image != null ? image!.toString() : null,
    };
  }
}
