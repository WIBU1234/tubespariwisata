import 'dart:convert';

class Review {
  int? id;
  int? idUser;
  int? idDestinasi;
  String review;
  int rating;

  Review({
    this.id,
    required this.idUser,
    required this.idDestinasi,
    required this.review,
    required this.rating,
  });

  factory Review.fromRawJson(String str) => Review.fromJson(json.decode(str));
  factory Review.fromJson(Map<String, dynamic> json) => Review(
        id: json["id"] ?? 0,
        idUser: json["idUser"],
        idDestinasi: json["idDestinasi"],
        review: json["review"],
        rating: json["rating"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id": id,
        "idUser": idUser,
        "idDestinasi": idDestinasi,
        "review": review,
        "rating": rating,
      };
}