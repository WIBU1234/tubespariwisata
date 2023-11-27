import 'dart:convert';

class Destinasi {
  int? id;
  String destinationName;
  String destinationAddress;
  String destinationDescription;
  double destinationLatitude;
  double destinationLongitude;
  String destinationImage;
  String destinationCategory;
  int destinationRating;

  Destinasi(
      {this.id,
      required this.destinationName,
      required this.destinationAddress,
      required this.destinationDescription,
      required this.destinationLatitude,
      required this.destinationLongitude,
      required this.destinationImage,
      required this.destinationCategory,
      required this.destinationRating}
  );

  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'destinationName': destinationName,
  //   'destinationAddress': destinationAddress,
  //   'destinationDescription': destinationDescription,
  //   'destinationLatitude': destinationLatitude,
  //   'destinationLongitude': destinationLongitude,
  //   'destinationImage': destinationImage,
  //   'destinationCategory': destinationCategory,
  //   'destinationRating': destinationRating,
  // };

  // static Destinasi fromJson(Map<String, dynamic> json) => Destinasi(
  //     id: json['id'],
  //     destinationName: json['destinationName'],
  //     destinationAddress: json['destinationAddress'],
  //     destinationDescription: json['destinationDescription'],
  //     destinationLatitude: json['destinationLatitude'],
  //     destinationLongitude: json['destinationLongitude'],
  //     destinationImage: json['destinationImage'],
  //     destinationCategory: json['destinationCategory'],
  //     destinationRating: json['destinationRating'],
  // );

  // UPDATE PLACEMENT
  factory Destinasi.fromRawJson(String str) => Destinasi.fromJson(json.decode(str));
  factory Destinasi.fromJson(Map<String, dynamic> json) => Destinasi(
    id: json["id"] ?? 0,
    destinationName: json["destinationName"],
    destinationAddress: json["destinationAddress"],
    destinationDescription: json["destinationDescription"],
    destinationLatitude: (json["destinationLatitude"] as num).toDouble(),
    destinationLongitude: (json["destinationLongitude"] as num).toDouble(),
    destinationImage: json["destinationImage"],
    destinationCategory: json["destinationCategory"],
    destinationRating: json["destinationRating"],
  );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
    "id": id,
    "destinationName": destinationName,
    "destinationAddress": destinationAddress,
    "destinationDescription": destinationDescription,
    "destinationLatitude": destinationLatitude,
    "destinationLongitude": destinationLongitude,
    "destinationImage": destinationImage,
    "destinationCategory": destinationCategory,
    "destinationRating": destinationRating,
  };

  // static List<Destinasi> fromJsonList(List<dynamic> jsonList) {
  //   return jsonList.map((json) => Destinasi.fromJson(json)).toList();
  // }

  static List<Destinasi> fromJsonList(Map<String, dynamic> jsonList) {
    // Assuming your API returns a JSON object with a key 'data' containing the list
    List<dynamic> destinationsData = jsonList['data'] ?? [];
    return destinationsData.map((json) => Destinasi.fromJson(json)).toList();
  }
}