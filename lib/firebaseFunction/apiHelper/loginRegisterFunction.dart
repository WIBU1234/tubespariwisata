import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/testingModel/loginModel.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart' as http;

class loginRegisHelper {
  static http.Client client = http.Client();
  // API URL
  static const String url = "192.168.239.1";
  static const String endpoint = "/tubesPariwisata/public/api/login";

  // static const String url = "10.0.2.2:8000";
  // static const String endpoint = '/api/login';

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

  static Future<User> loginById({required int id}) async {
    String endpointV2 = '/tubesPariwisata/public/api/loginById';
    // String endpointV2 = '/api/loginById';

    String idUser = id.toString();

    try{
      var apiResult = await client.post(Uri.http(url, endpointV2),
        body: {"id": idUser});

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