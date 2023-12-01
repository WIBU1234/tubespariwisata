import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/testingModel/loginModel.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;

class loginRegisHelper {
  static http.Client client = http.Client();
  // API URL
  // static const String url = "192.168.62.1";
  // static const String endpoint = "/tubesPariwisata/public/api/login";

  static const String url = "127.0.0.1:8000";
  static const String endpoint = '/api/login';

  static Future<User> login({required String username, required String password}) async {
    try{
      var apiResult = await client.post(Uri.http(url, endpoint), 
        body: {"username": username, "password": password}
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

  static Future<LoginModel> loginTesting({required String username, required String password}) async {

    try{
      var apiResult = await client.post(Uri.http(url, endpoint), 
        body: {"username": username, "password": password}
        );

        if(apiResult.statusCode == 200) {
          final result = LoginModel.fromRawJson(apiResult.body);
          return result;
        } else {
          throw Exception('Failed to login');
        }
    } catch (e) {
      throw Exception('Error : ' + e.toString());
    }
  }
}