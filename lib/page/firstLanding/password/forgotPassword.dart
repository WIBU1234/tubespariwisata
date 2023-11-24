// FLUTTER LIB IMPORTER
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:intl/intl.dart';
// PAGE IMPORTER
import 'package:tubespariwisata/entity/user.dart';
// FUNCTION IMPORTER
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiUserFunction.dart';
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
// LAUNCHER IMPORTER
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class Forgotpage extends StatefulWidget {
  const Forgotpage({Key? superKey}): super(key: superKey);

  @override
  State<Forgotpage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<Forgotpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController controllerTanggalLahir = TextEditingController();
  bool isPasswordVisible = true;
  List<User> userList = [];
  User userTemp = User(
    id: 0,
    username: "",
    email: "",
    password: "",
    nomorTelepon: "",
    tanggalLahir: "",
    imageFoto: "",
    token: "");

  @override
  void initState() {
    setForce();
    super.initState();
  }

  void setForce() async {
    userList = await ApiFunctionHelper.getUser();
  }

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        controllerTanggalLahir.text =
            DateFormat('yyyy-MM-dd').format(picked).toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ImageFiltered(
            imageFilter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0),
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resources/images/bali.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Center(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.4),
                    offset: const Offset(0, 3),
                    blurRadius: 6,
                  ),
                ],
              ),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('resources/images/logo.png',
                        width: 150, height: 150),

                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your credentials to log in',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.person),
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),
                      validator: (value) =>
                          value == '' ? 'Please enter your username' : null,
                    ),

                    const SizedBox(height: 24),
                    TextFormField(
                      controller: controllerTanggalLahir,
                      onTap: selectDate,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.date_range),
                        labelText: 'Date of Birth',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
                      ),
                      validator: (value) {
                        if(value == ''){
                          return 'Please enter your date of birth';
                        }
                        return null;
                      }
                    ),

                    const SizedBox(height: 30),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 6,
                      ),
                      onPressed: () {
                        userTemp = ApiFunctionHelper.searchUserForForgot(userList, usernameController.text, controllerTanggalLahir.text);
                        if (userTemp.id != -240) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil masuk ke halaman recovery'),
                            ),
                          );
                          saveUserID(userTemp.id.toString());
                          pushForgotPasswordNew(context, userTemp);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                  'Username atau Tanggal Lahir salah !'),
                            ),
                          );
                        }
                      },
                      child: const Text(
                        'Verify',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),

                    const SizedBox(height: 22),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(width: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Back To Login',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    pushRegister(context);
                                  },
                              ),
                            ],
                          ),
                        ),

                        // const SizedBox(width: 8),
                        // Text.rich(
                        //   TextSpan(
                        //     children: [
                        //       TextSpan(
                        //         text: 'Forgot Password?',
                        //         style: const TextStyle(
                        //           color: Colors.blue,
                        //           decoration: TextDecoration.underline,
                        //         ),
                        //         recognizer: TapGestureRecognizer()
                        //           ..onTap = () {
                        //             // pushForgotPassword(context);
                        //           },
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
