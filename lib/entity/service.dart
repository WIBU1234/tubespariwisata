import 'dart:convert';

class Service{
  int? id;
  int idTicket;
  int idDestinasi;

  Service({
    this.id,
    required this.idTicket,
    required this.idDestinasi,
  });

  factory Service.fromRawJson(String str) => Service.fromJson(json.decode(str));
  factory Service.fromJson(Map<String, dynamic> json) => Service(
    id: json["id"] ?? 0,
    idTicket: json["idTicket"],
    idDestinasi: json["idDestinasi"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "idTicket": idTicket,
    "idDestinasi": idDestinasi,
  };
}