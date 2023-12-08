// ENTITY
import 'package:tubespariwisata/entity/book.dart';
import 'package:tubespariwisata/entity/ticket.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;
// IMPORT GLOBAL URL
import 'package:tubespariwisata/firebaseFunction/apiHelper/globalURL.dart';

class ApiTicketHelper{
  static http.Client client = http.Client();
  // API URL
  static const String url = globalURL.url;
  static const String endpoint = '/tubesPariwisata/public/api/ticket';

  // static const String url = globalURL.url;
  // static const String endpoint = '/api/ticket';
  
  static Stream<List<Book>> getTicketStream({required int id}) async* {
    String endpointV2 = "/tubesPariwisata/public/api/getAllTicketByIDUser";
    // String endpointV2 = "/api/getAllTicketByIDUser";

    String idUser = id.toString();

    try {
      var apiResult = await client.post(Uri.http(url, endpointV2),
        body: {"idUser": idUser});

        if(apiResult.statusCode == 200){
          Iterable list = json.decode(apiResult.body)['data'];

          yield list.map((book) => Book.fromJson(book)).toList();
        } else {
          throw Exception(apiResult.reasonPhrase);
        }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<Ticket> getTicketById(int id) async {
    try {
      var response = await http.get(Uri.http(url, endpoint + '/' + id.toString()));

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return Ticket.fromJson(json.decode(response.body)['data']);
    } catch (e) {
      print("Throw Error");
      throw Exception(e.toString());
    }
  }
}