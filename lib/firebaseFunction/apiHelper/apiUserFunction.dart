// ENTITY
import 'package:tubespariwisata/entity/user.dart';
// TOOLS
import 'dart:convert';
import 'package:http/http.dart';

class ApiFunctionHelper {
  // API URL
  static const String url = "192.168.91.1";
  static const String endpoint = '/tubesPariwisata/public/api/user';

  // static const String url = "127.0.0.1:8000";
  // static const String endpoint = '/api/user';

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

  static Future<List<User>> fetchAll() async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      return list.map((user) => User.fromJson(user)).toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<User> searchUserForLogin(String username, String password) async {
    try {
      var response = await get(Uri.http(url, endpoint));

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      Iterable list = json.decode(response.body)['data'];

      for (var user in list) {
        if (user['username'] == username && user['password'] == password) {
          return User.fromJson(user);
        }
      }

      throw Exception("User not found");
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

  static User searchUserByLogin(List<User> user, String username, String password) {
  for (var user in user) {
    if (user.email == username && user.password == password) {
      return user;
    }
  }
  return User(
      id: -240,
      username: "",
      email: "",
      password: "",
      nomorTelepon: "",
      tanggalLahir: "",
      token: "",
      imageFoto: "");
  }

  static User searchUserForForgot(List<User> user, String username, String tanggalLahir) {
    for (var user in user) {
      if (user.username == username && user.tanggalLahir == tanggalLahir) {
        return user;
      }
    }
    return User(
        id: -240,
        username: "",
        email: "",
        password: "",
        nomorTelepon: "",
        tanggalLahir: "",
        token: "",
        imageFoto: "");
  }

  static Future<Response> updatePassword(User user) async {
    try {
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  static Future<Response> insertUpdateImage(User user) async {
    try{
      var response = await put(Uri.http(url, '$endpoint/${user.id}'),
          headers: {"Content-Type": "application/json"},
          body: user.toRawJson());

      if (response.statusCode != 200) throw Exception(response.reasonPhrase);

      return response;
    } catch (e) {
      return Future.error(e.toString());
    }
  }
}