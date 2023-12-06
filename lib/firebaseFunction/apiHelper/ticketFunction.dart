// ENTITY
import 'package:tubespariwisata/entity/ticket.dart';
import 'package:tubespariwisata/entity/book.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiTicketHelper{
  static http.Client client = http.Client();
  // API URL
  static const String url = "192.168.239.1";
  static const String endpoint = '/tubesPariwisata/public/api/ticket';

  // static const String url = "10.0.2.2:8000";
  // static const String endpoint = '/api/ticket';
  
  static Stream<List<Book>> getTicketStream({required int id}) async* {
    String endpointV2 = "/tubesPariwisata/public/api/getAllTicketByIDUser";
    // String endpointV2 = "/api/getAllTicketByIDUser";

    String idUser = id.toString();
    print("Ini ID USER : $idUser");

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
      print("Ini ID USER : $idUser");
      throw Exception(e.toString());
    }
  }

  // static Future<List<Ticket>> getTicketForDropdown() async {
  //   try {
  //     var response = await get(Uri.http(url, endpoint),
  //         headers: {"Content-Type": "application/json", "Accept": "application/json"},      
  //         );

  //     if(response.statusCode != 200) throw Exception(response.reasonPhrase);

  //     List<Ticket> ticket = (jsonDecode(response.body) as List)
  //         .map((e) => Ticket.fromJson(e))
  //         .toList();

  //     return ticket;
  //   } catch (e) {
  //     return Future.error(e.toString());
  //   }
  // } 
}