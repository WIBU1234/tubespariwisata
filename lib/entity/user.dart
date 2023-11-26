import 'dart:convert';

class User {
  int? id;
  String username;
  String email;
  String password;
  String nomorTelepon;
  String tanggalLahir;
  String imageFoto;
  String token;

  User({
    this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.nomorTelepon,
    required this.tanggalLahir,
    required this.imageFoto,
    required this.token,
  });

  int? get getId => id;

  // CREATE EMPTY
  factory User.empty() => User(
        id: null,
        username: "",
        email: "",
        password: "",
        nomorTelepon: "",
        tanggalLahir: "",
        imageFoto: "",
        token: "",
      );

  // UPDATE PLACEMENT
  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] ?? 0,
        username: json["username"],
        email: json["email"],
        password: json["password"],
        nomorTelepon: json["nomorTelepon"],
        tanggalLahir: json["tanggalLahir"],
        token: json["token"],
        imageFoto: json["imageFoto"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "username": username,
        "email": email,
        "password": password,
        "nomorTelepon": nomorTelepon,
        "tanggalLahir": tanggalLahir,
        "token": token,
        "imageFoto": imageFoto,
      };

  // Map<String, dynamic> toJson() => {
  //       'id': id,
  //       'username': username,
  //       'email': email,
  //       'password': password,
  //       'nomorTelepon': nomorTelepon,
  //       'tanggalLahir': tanggalLahir,
  //       'token': token,
  //       'imageFoto': imageFoto,
  //     };

  // static User fromJson(Map<String, dynamic> json) => User(
  //       id: json['id'],
  //       username: json['username'],
  //       email: json['email'],
  //       password: json['password'],
  //       nomorTelepon: json['nomorTelepon'],
  //       tanggalLahir: json['tanggalLahir'],
  //       token: json['token'],
  //       imageFoto: json['imageFoto'],
  //     );
}
