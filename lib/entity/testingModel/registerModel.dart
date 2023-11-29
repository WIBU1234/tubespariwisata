import 'dart:convert';
import 'package:tubespariwisata/entity/user.dart';

class RegisterModel {
  final int status;
  final String message;
  final User user;

  const RegisterModel({
    required this.status,
    required this.message,
    required this.user,
  });

  factory RegisterModel.fromRawJson(String str) => RegisterModel.fromJson(json.decode(str));
  
  String toRawJson() => json.encode(toJson());
  
  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
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