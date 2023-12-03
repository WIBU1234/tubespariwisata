// ENTITY
import 'package:logger/logger.dart';
import 'package:tubespariwisata/entity/ticket.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiTicketHelper{
  // API URL
  static const String url = "192.168.62.1";
  static const String endpoint = '/tubesPariwisata/public/api/ticket';

  // static const String url = "127.0.0.1:8000";
  // static const String endpoint = '/api/ticket';

  static Future<Response> createTicket({
    required String ticketName,
    required String status,
    required int quantity,
    required double ticketPrice,
  }) async {
    try {
      // Logger().i(input.toRawJson());

      var data = {
          "idTicket" : 0,
          "ticketName": ticketName,
          "status": status,
          "quantity": quantity,
          "ticketPrice": ticketPrice
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

  static Future<Response> updateTicket({
    required Ticket input,
  }) async {
    try {
      Logger().i(input.toRawJson());

      var data = {
          "idTicket" : input.id,
          "ticketName": input.ticketName,
          "status": input.status,
          "quantity": input.quantity,
          "ticketPrice": input.ticketPrice
      };

      var response = await put(Uri.http(url, endpoint + '/${input.id}'),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          body: jsonEncode(data),
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> deleteTicket({
    required int id,
  }) async {
    try {
      var response = await delete(Uri.http(url, endpoint + '/$id'),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Ticket>> getTicket() async {
    try {
      var response = await get(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<Ticket> ticket = (jsonDecode(response.body) as List)
          .map((e) => Ticket.fromJson(e))
          .toList();

      return ticket;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<List<Ticket>> getTicketForDropdown() async {
    try {
      var response = await get(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json", "Accept": "application/json"},      
          );

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      List<Ticket> ticket = (jsonDecode(response.body) as List)
          .map((e) => Ticket.fromJson(e))
          .toList();

      return ticket;
    } catch (e) {
      return Future.error(e.toString());
    }
  } 
}