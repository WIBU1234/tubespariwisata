// ENTITY
// import 'package:tubespariwisata/entity/book.dart';
// import 'package:tubespariwisata/entity/ticket.dart';
// TOOLS
import 'package:http/http.dart' as http;
// IMPORT GLOBAL URL
import 'package:tubespariwisata/firebaseFunction/apiHelper/globalURL.dart';

class ApiBookHelper{
  static http.Client client = http.Client();
  // API URL
  static const String url = globalURL.url;
  static const String endpoint = '/tubesPariwisata/public/api/book';

  // static const String url = globalURL.url;
  // static const String endpoint = '/api/book';

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