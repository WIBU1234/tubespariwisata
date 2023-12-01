import 'package:tubespariwisata/entity/user.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;

class loginRegisHelper {
  // API URL
  static const String url = "192.168.158.1";
  static const String endpoint = '/tubesPariwisata/public/api/login';
  static http.Client client = http.Client();

  static Future<User> login({required String username, required String password}) async {
    String apiURL = '192.168.158.1/api/login';

    try{
      var apiResult = await client.post(Uri.parse(apiURL), 
        body: {"username": username, "password": password}
        );

        if(apiResult.statusCode == 200) {
          return User.fromJson(json.decode(apiResult.body));
        } else {
          return User.empty();
        }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}