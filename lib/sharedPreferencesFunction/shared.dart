import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'dart:convert';

// SAFE BY ID
Future<String?> saveUserID(String userID) async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userID', userID);
  return userID;
}

Future<String?> getUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('userID');
  return stringValue;
}

Future removeUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userID');
}

// SAFE BY USER
Future<User?> saveUserForObject(User user) async {
  final prefs = await SharedPreferences.getInstance();  
  await prefs.setString('user', jsonEncode(user));
  return user;
}

Future<User?> getUserForObject() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? stringValue = prefs.getString('user');
  if (stringValue != null) {
    return User.fromJson(jsonDecode(stringValue));
  } else {
    return null;
  }
}

Future removeUserForObject() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('user');
}