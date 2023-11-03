class User{
  final String? id;
  final String username;
  final String email;
  final String password;
  final String nomorTelepon;
  final String tanggalLahir;
  final String imageFoto;
  final String token;

  User({this.id, required this.username, required this.email, required this.password, required this.nomorTelepon, required this.tanggalLahir, required this.imageFoto, required this.token});

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'password': password,
    'nomorTelepon': nomorTelepon,
    'tanggalLahir': tanggalLahir,
    'token': token,
    'imageFoto': imageFoto,
  };

  static User fromJson(Map<String, dynamic> json) => User(
    id: json['id'],
    username: json['username'],
    email: json['email'],
    password: json['password'],
    nomorTelepon: json['nomorTelepon'],
    tanggalLahir: json['tanggalLahir'],
    token: json['token'],
    imageFoto: json['imageFoto'],
  );
}