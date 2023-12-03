import 'dart:convert';
import 'package:tubespariwisata/entity/user.dart';

class LoginModel {
  final int status;
  final String message;
  final User user;

  const LoginModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory LoginModel.fromRawJson(String str) => LoginModel.fromJson(json.decode(str));
  
  String toRawJson() => json.encode(toJson());
  
  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
    status: json["status"],
    message: json["message"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "user": user.toJson(),
  };
}