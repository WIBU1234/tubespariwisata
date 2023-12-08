// ENTITY
import 'package:tubespariwisata/entity/book.dart';
import 'package:uuid/uuid.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;
// IMPORT GLOBAL URL
import 'package:tubespariwisata/firebaseFunction/apiHelper/globalURL.dart';

class ApiBookHelper{
  static http.Client client = http.Client();
  // API URL
  static const String url = globalURL.url;
  // static const String endpoint = '/tubesPariwisata/public/api/book';

  // static const String url = globalURL.url;
  static const String endpoint = '/api/book';

  static Future<void> loopNumberofTicket(Book book, int numberStore) async {
    for(int i = 0; i < numberStore; i++){
      await storeDataBooking(book, numberStore);
    }
  }

  static Future<http.Response> storeDataBooking(Book book, int numberStore) async {

    book.nomorResi = Uuid().v4().substring(0, 5);

    try{
      var apiResult = await client.post(Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"}, 
        body: jsonEncode(book));

        if(apiResult.statusCode == 200){
          return apiResult;
        } else {
          throw Exception(apiResult.reasonPhrase);
        }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<int> deleteDataBooking(int id) async {
    try {
      var response = await http.delete(Uri.http(url, endpoint + '/' + id.toString()));

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response.statusCode;
    } catch (e) {
      print("Throw Error");
      throw Exception(e.toString());
    }
  }
}