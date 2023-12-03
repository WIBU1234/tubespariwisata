// ENTITY
import 'package:logger/logger.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiDestinasiHelper {
  // API URL
  static const String url = "192.168.62.1";
  static const String endpoint = '/tubesPariwisata/public/api/destinasi';

  // static const String url = "127.0.0.1:8000";
  // static const String endpoint = '/api/destinasi';

  static Future<Response> createDestinasi({
    required String destinationName,
    required String alamatDestinasi,
    required String deskripsiDestinasi,
    required double latitude,
    required double longitude,
    required String imageFoto,
    required String destinationCategory,
    required int rating,
    required double destinationPrice,
  }) async {
    try {
      Destinasi input = Destinasi(
        destinationName: destinationName,
        destinationAddress: alamatDestinasi,
        destinationDescription: deskripsiDestinasi,
        destinationLatitude: latitude,
        destinationLongitude: longitude,
        destinationImage: imageFoto,
        destinationCategory: destinationCategory,
        destinationRating: rating,
        destinationPrice: destinationPrice,
      );

      // Logger().i(input.toRawJson());

      // print(imageFoto);

      var data = {
          "destinationName": destinationName,
          "destinationAddress": alamatDestinasi,
          "destinationDescription": deskripsiDestinasi,
          "destinationLatitude": latitude,
          "destinationLongitude": longitude,
          "destinationImage": imageFoto,
          "destinationCategory": destinationCategory,
          "destinationRating": rating,
          "destinationPrice": destinationPrice
      };

      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          body: jsonEncode(data),
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> updateDestinasi({
    required int id,
    required String destinationName,
    required String alamatDestinasi,
    required String deskripsiDestinasi,
    required double latitude,
    required double longitude,
    required String imageFoto,
    required String destinationCategory,
    required int rating,
    required double destinationPrice,
  }) async {
    try {
      Destinasi input = Destinasi(
        destinationName: destinationName,
        destinationAddress: alamatDestinasi,
        destinationDescription: deskripsiDestinasi,
        destinationLatitude: latitude,
        destinationLongitude: longitude,
        destinationImage: imageFoto,
        destinationCategory: destinationCategory,
        destinationRating: rating,
        destinationPrice: destinationPrice,
      );

      Logger().i(input.toRawJson());

      print(imageFoto);

      var data = {
          "destinationName": destinationName,
          "destinationAddress": alamatDestinasi,
          "destinationDescription": deskripsiDestinasi,
          "destinationLatitude": latitude,
          "destinationLongitude": longitude,
          "destinationImage": imageFoto,
          "destinationCategory": destinationCategory,
          "destinationRating": rating,
          "destinationPrice": destinationPrice
      };

      var response = await put(Uri.http(url, endpoint + '/' + id.toString()),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          body: jsonEncode(data),
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> deleteDestinasi(int id) async {
    try {
      var response = await delete(Uri.http(url, endpoint + '/' + id.toString()),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Stream<List<Destinasi>> getDestinasi() async* {
    try {
      var response = await get(Uri.http(url, endpoint));

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      yield list.map((destinasi) => Destinasi.fromJson(destinasi)).toList();

    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static printAll(List<Destinasi> destinasi){
    for(var destinasi in destinasi){
      print(destinasi);
      print("BUAHAHHAHA");
    }
  }
}