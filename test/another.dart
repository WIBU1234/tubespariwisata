import 'package:flutter_test/flutter_test.dart';
import 'package:http/testing.dart';
import 'package:http/http.dart' as http;

import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';

void main() {
  test('Test login function', () async {
    const jsonResponse = '''
    {
      "status": 200,
      "message": "Login Success",
      "data": {
        "id": 2,
        "username": "12",
        "email": "12",
        "password": "121212",
        "nomorTelepon": "12",
        "tanggalLahir": "2023-11-27",
        "imageFoto": "NOTHAVE",
        "token": "0",
        "created_at": "2023-11-27 12:40:30",
        "updated_at": "2023-11-27 12:40:30"
      }
    }
    ''';

    final client = MockClient((request) async {
      if (request.url.toString() == '127.0.0.1:8000/api/login' &&
          request.bodyFields['username'] == '12' &&
          request.bodyFields['password'] == '121212') {
        return http.Response(jsonResponse, 200);
      }

      return http.Response('{"success": "false", "message": "Invalid credentials"}', 400);
    });

    loginRegisHelper.client = client;

    final user = await loginRegisHelper.login(username: '12', password: '121212');

    expect(user.username, '12');
    expect(user.password, '121212');
  });
}