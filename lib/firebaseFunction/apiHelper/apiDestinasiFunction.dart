// ENTITY
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiDestinasiHelper {
  // API URL
  static const String url = "10.0.2.2:8000";
  static const String endpoint = '/api/destinasi';

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
        id: null,
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
          "destinationImage": "imageFoto",
          "destinationCategory": destinationCategory,
          "destinationRating": rating
      };

      var response = await post(Uri.http(url  , endpoint),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          body: input.toRawJson());
      
      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> getDestinations() async {
    try {
      var response = await get(Uri.http(url, endpoint));
      
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      
      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<void> deleteDestination(String id) async {
    try {
      final response = await http.delete(
        Uri.parse('http://10.0.2.2:8000/api/destinasi/$id'), 
      );

      if (response.statusCode == 200) {
        print('Destination deleted successfully');
      } else {
        print('Failed to delete destination. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting destination: $e');
    }
  }

  static Future<Response> updateDestination({
    required String id,
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
        id: int.parse(id),
        destinationName: destinationName,
        destinationAddress: alamatDestinasi,
        destinationDescription: deskripsiDestinasi,
        destinationLatitude: latitude,
        destinationLongitude: longitude,
        destinationImage: imageFoto,
        destinationCategory: destinationCategory,
        destinationRating: rating,
      );

      var response = await put(
        Uri.http(url, '/api/destinasi/$id'),
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: input.toRawJson(),
      );

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}