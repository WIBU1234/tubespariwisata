import 'dart:convert';

class Book {
  int? id;
  int idUser;
  int idDestinasi;
  int idTicket;
  String nomorResi;
  String dateofDeparture;
  String dateofReturn;

  Book({
    this.id,
    required this.idUser,
    required this.idDestinasi,
    required this.idTicket,
    required this.nomorResi,
    required this.dateofDeparture,
    required this.dateofReturn,
  });

  factory Book.fromRawJson(String str) => Book.fromJson(json.decode(str));
  factory Book.fromJson(Map<String, dynamic> json) => Book(
    id: json["id"] ?? 0,
    idUser: json["idUser"],
    idDestinasi: json["idDestinasi"],
    idTicket: json["idTicket"],
    nomorResi: json["nomorResi"],
    dateofDeparture: json["dateofDeparture"],
    dateofReturn: json["dateofReturn"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "idUser": idUser,
    "idDestinasi": idDestinasi,
    "idTicket": idTicket,
    "nomorResi": nomorResi,
    "dateofDeparture": dateofDeparture,
    "dateofReturn": dateofReturn,
  };
}