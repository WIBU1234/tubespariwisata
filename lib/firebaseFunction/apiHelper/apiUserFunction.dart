// ENTITY
import 'package:tubespariwisata/entity/user.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiFunctionHelper {
  // API URL
  static const String url = "192.168.36.1";
  static const String endpoint = 'tubesPariwisata/public/api/user';

  static Future<Response> createUser({
    required String username,
    required String email,
    required String password,
    required String nomorTelepon,
    required String tanggalLahir,
    required String token,
  }) async {
    try {

      User input = User(
        id: null,
        username: username,
        email: email,
        password: password,
        nomorTelepon: nomorTelepon,
        tanggalLahir: tanggalLahir,
        imageFoto: "NOTHAVE",
        token: token
      );

      var response = await post(Uri.http(url, endpoint),
          headers: {"Content-Type": "application/json"},      
          body: input.toRawJson());

      if(response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Stream<List<User>> getUser() async* {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      yield list.map((user) => User.fromJson(user)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static bool isUserInList(List<User> user, String email) {
    for (var user in user) {
      if (user.email == email) {
        return true;
      }
    }
    return false;
  }

  static Future<User?> searchUserByLogin(List<User> user, String username, String password) async {
    for (var user in user) {
      if (user.email == username && user.password == password) {
        return user;
      }
    }
    return User(
        id: 0,
        username: "",
        email: "",
        password: "",
        nomorTelepon: "",
        tanggalLahir: "",
        token: "",
        imageFoto: "");
  }
}