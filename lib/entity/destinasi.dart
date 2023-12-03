import 'dart:convert';

class Destinasi {
  int? id;
  int? idTicket;
  String destinationName;
  String destinationAddress;
  String destinationDescription;
  double destinationLatitude;
  double destinationLongitude;
  String destinationImage;
  String destinationCategory;
  int destinationRating;
  double destinationPrice;

  Destinasi(
      {this.id,
      this.idTicket,
      required this.destinationName,
      required this.destinationAddress,
      required this.destinationDescription,
      required this.destinationLatitude,
      required this.destinationLongitude,
      required this.destinationImage,
      required this.destinationCategory,
      required this.destinationRating,
      required this.destinationPrice});

  // UPDATE PLACEMENT
  factory Destinasi.fromRawJson(String str) => Destinasi.fromJson(json.decode(str));
  factory Destinasi.fromJson(Map<String, dynamic> json) => Destinasi(
    id: json["id"] ?? 0,
    idTicket: json["idTicket"] ?? 0,
    destinationName: json["destinationName"],
    destinationAddress: json["destinationAddress"],
    destinationDescription: json["destinationDescription"],
    destinationLatitude: (json["destinationLatitude"] as num).toDouble(),
    destinationLongitude: (json["destinationLongitude"] as num).toDouble(),
    destinationImage: json["destinationImage"],
    destinationCategory: json["destinationCategory"],
    destinationRating: json["destinationRating"],
    destinationPrice: (json["destinationPrice"] as num).toDouble(),
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "idTicket": idTicket,
    "destinationName": destinationName,
    "destinationAddress": destinationAddress,
    "destinationDescription": destinationDescription,
    "destinationLatitude": destinationLatitude,
    "destinationLongitude": destinationLongitude,
    "destinationImage": destinationImage,
    "destinationCategory": destinationCategory,
    "destinationRating": destinationRating,
    "destinationPrice": destinationPrice,
  };
}