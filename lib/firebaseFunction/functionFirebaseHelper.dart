import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubespariwisata/entity/user.dart';

// USER DATA MANAGEMENT OR MANIPULATION
Future createUser({
  required String username,
  required String email,
  required String password,
  required String nomorTelepon,
  required String tanggalLahir,
  required String token,
}) async {
  try {
    final docUser = FirebaseFirestore.instance.collection('user').doc();

    final user = User(
        id: docUser.id,
        username: username,
        email: email,
        password: password,
        nomorTelepon: nomorTelepon,
        tanggalLahir: tanggalLahir,
        imageFoto: "NOTHAVE",
        token: '0');
    final json = user.toJson();

    await docUser.set(json);
  } catch (e) {
    print('Error creating user: $e');
  }
}

Stream<List<User>> getUser() =>
    FirebaseFirestore.instance.collection('user').snapshots().map((snapshots) =>
        snapshots.docs.map((doc) => User.fromJson(doc.data())).toList());

bool isUserInList(List<User> user, String email) {
  for (var user in user) {
    if (user.email == email) {
      return true;
    }
  }
  return false;
}

User searchUserByLogin(List<User> user, String username, String password) {
  for (var user in user) {
    if (user.email == username && user.password == password) {
      return user;
    }
  }
  return User(
      id: null,
      username: "",
      email: "",
      password: "",
      nomorTelepon: "",
      tanggalLahir: "",
      token: "",
      imageFoto: "");
}