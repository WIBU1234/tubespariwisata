// ENTITY
// import 'package:logger/logger.dart';
import 'package:logger/logger.dart';
import 'package:test/expect.dart';
import 'package:tubespariwisata/entity/review.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiDestinasiHelper {
  // API URL
  static const String url = "20.255.52.134";
  static const String endpoint = '/tubesPariwisata/public/api/ticket';

  // static const String url = "127.0.0.1:8000";
  // static const String endpoint = '/api/ticket';

  static Future<Response> createTicket({
    required int idUser,
    required int idDestinasi,
    required int review,
    required int rating,
  }) async {
    try {
      var data = {
        "idUser": idUser,
        "idDestinasi": idDestinasi,
        "review": review,
        "rating": rating,
      };

      var response = await post(
        Uri.http(url, endpoint),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateTicket({
    required int id,
    required int idUser,
    required int idDestinasi,
    required int review,
    required int rating,
  }) async {
    try {
      var data = {
        "id": id,
        "idUser": idUser,
        "idDestinasi": idDestinasi,
        "review": review,
        "rating": rating,
      };

      // Logger().i(input.toRawJson());

      // print(imageFoto);

      var response = await put(
        Uri.http(url, endpoint + '/' + id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: jsonEncode(data),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> deleteReview(int id) async {
    try {
      var response = await delete(
        Uri.http(url, endpoint + '/' + id.toString()),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Stream<List<Review>> getReview() async* {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      yield list.map((review) => Review.fromJson(review)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static printAll(List<Review> reviews) {
    for (var review in reviews) {
      print(review);
    }
  }
}
