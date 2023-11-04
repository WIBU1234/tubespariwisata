import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tubespariwisata/entity/user.dart';

// USER DATA MANAGEMENT OR MANIPULATION
User createEmptyUser() {
  return User(
      id: "",
      username: "",
      email: "",
      password: "",
      nomorTelepon: "",
      tanggalLahir: "",
      token: "",
      imageFoto: "");
}

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

Future<User?> searchUserByShared(String idUser) async {
  final querySnapshot = await FirebaseFirestore.instance
      .collection('user')
      .where('id', isEqualTo: idUser)
      .get();
  if (querySnapshot.size > 0) {
    final doc = querySnapshot.docs[0];
    final data = doc.data();
    return User.fromJson(data);
  } else {
    return null;
  }
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

void editUserData(String idUser, Map<String, dynamic> newData) {
  FirebaseFirestore.instance
      .collection('user')
      .where('id', isEqualTo: idUser)
      .get()
      .then((QuerySnapshot querySnapshot) {
    querySnapshot.docs.forEach((doc) {
      doc.reference.update(newData);
    });
  });
}
