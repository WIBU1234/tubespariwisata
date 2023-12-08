import 'package:tubespariwisata/entity/user.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;
// IMPORT GLOBAL URL
import 'package:tubespariwisata/firebaseFunction/apiHelper/globalURL.dart';

class loginRegisHelper {
  static http.Client client = http.Client();
  // API URL
  static const String url = globalURL.url;
  static const String endpoint = "/tubesPariwisata/public/api/login";

  // static const String url = globalURL.url;
  // static const String endpoint = '/api/login';

  static Future<User> login({required String username, required String password}) async {
    try{
      var apiResult = await client.post(Uri.http(url, endpoint),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"username": username, "password": password})
        );

        if(apiResult.statusCode == 200) {
          return User.fromJson(json.decode(apiResult.body)['data']);
        } else {
          return User.empty();
        }
    } catch (e) {
      // return User.empty();
      throw Exception(e.toString());
    }
  }

  static Future<User> loginById({required int id}) async {
    String endpointV2 = '/tubesPariwisata/public/api/loginById';
    // String endpointV2 = '/api/loginById';

    String idUser = id.toString();

    try{
      var apiResult = await client.post(Uri.http(url, endpointV2),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"id": idUser}));

        if(apiResult.statusCode == 200) {
          return User.fromJson(json.decode(apiResult.body)['data']);
        } else {
          return User.empty();
        }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}