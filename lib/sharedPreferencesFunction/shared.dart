import 'package:shared_preferences/shared_preferences.dart';

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