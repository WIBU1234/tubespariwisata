// ENTITY
import 'package:logger/logger.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiDestinasiHelper {
  // API URL
  static const String url = "192.168.158.1";
  static const String endpoint = 'tubesPariwisata/public/api/destinasi';

  static Future<Response> createDestinasi({
    required String destinationName,
    required String alamatDestinasi,
    required String deskripsiDestinasi,
    required double latitude,
    required double longitude,
    required String imageFoto,
    required String destinationCategory,
    required int rating,
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
          "destinationRating": rating
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
}