// FLUTTER LIB IMPORTER
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// PAGE IMPORTER
import 'package:tubespariwisata/entity/user.dart';
// FUNCTION IMPORTER
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiUserFunction.dart';
// LAUNCHER IMPORTER
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class NewPasswordPage extends StatefulWidget {
  const NewPasswordPage({Key? superKey, required this.user}): super(key: superKey);

  final User user;

  @override
  State<NewPasswordPage> createState() => _NewPasswordPageState();
}

class _NewPasswordPageState extends State<NewPasswordPage> {
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordNewController = TextEditingController();
  bool isPasswordVisible = true;
  bool isPasswordNewVisible = true;
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
    setTheVariable();
    super.initState();
  }

  void setTheVariable(){
    setState(() {
      userTemp = widget.user;
    });
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
                    const Center(
                      child: Text(
                        'Please enter correct username and date of birth to reset your password',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 17),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color:
                                isPasswordVisible ? Colors.grey : Colors.blue,
                          ),
                        ),
                      ),
                      obscureText: isPasswordVisible,
                      validator: (value) =>
                          value == '' ? 'Please enter your new password' : null,
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordNewController,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.lock),
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(vertical: 17),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              isPasswordNewVisible = !isPasswordNewVisible;
                            });
                          },
                          icon: Icon(
                            isPasswordNewVisible
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color:
                                isPasswordNewVisible ? Colors.grey : Colors.blue,
                          ),
                        ),
                      ),
                      obscureText: isPasswordNewVisible,
                      validator: (value) =>
                          value == '' ? 'Please confirm your new password' : null,
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
                        if(passwordController.text == passwordNewController.text) {
                          userTemp.password = passwordController.text;
                          ApiFunctionHelper.updatePassword(userTemp);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Berhasil mengubah password'),
                            ),
                          );
                          pushLogin(context);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Password tidak sama'),
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
