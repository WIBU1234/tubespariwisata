// FLUTTER LIB IMPORTER
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
// PAGE IMPORTER
import 'package:tubespariwisata/entity/user.dart';
// FUNCTION IMPORTER
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiUserFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
// LAUNCHER IMPORTER
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class Loginpage extends StatefulWidget {
  const Loginpage({Key? key}) : super(key: key);

  @override
  State<Loginpage> createState() => _LoginPageState();
}

class _LoginPageState extends State<Loginpage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = true;
  List<User> userList = [];
  User userTemp = User.empty();

  @override
  void initState() {
    setForce();
    super.initState();
  }

  void setForce() {
    ApiFunctionHelper.getUser().listen((users) {
      setState(() {
        userList = users;
      });
    }, onError: (error) {

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
                    const Text(
                      'Welcome!',
                      style:
                          TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),

                    const SizedBox(height: 10),
                    const Text(
                      'Please enter your credentials to log in',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),

                    const SizedBox(height: 20),
                    TextFormField(
                      key: const Key('usernameField'),
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
                      key: const Key('passwordField'),
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
                          value == '' ? 'Please enter your username' : null,
                    ),

                    const SizedBox(height: 30),
                    ElevatedButton(
                      key: const Key('loginButton'),
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

                        if(usernameController.text == "admin" && passwordController.text == "admin") {
                          saveUserID("admin");
                          popper(context);
                          
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Welcome Admin'),
                            ),
                          );

                          pushAdminHomePage(context); 
                        } else {
                          setState(()  {
                            ApiFunctionHelper.getUser().listen((users) {
                              setState(() {
                                userList = users;
                              });
                            }, onError: (error) {

                            });
                          });

                          setForce();
                          userTemp = ApiFunctionHelper.searchUserByLogin(userList, usernameController.text, passwordController.text);

                          loginRegisHelper.login(username: usernameController.text, password: passwordController.text).then((user) {
                            setState(() {
                              userTemp = user;
                              if (userTemp.id != -240) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('Success Login! User ID: ${userTemp.id}'),
                                  ),
                                );
                                saveUserID(userTemp.id.toString());

                                pushHomePage(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Login failed. Please check your credentials.'),
                                  ),
                                );
                              }
                            });
                          });
                        }

                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Sign Up',
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
                          key: const Key('signUpText'),
                        ),

                        const SizedBox(width: 8),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'Forgot Password?',
                                style: const TextStyle(
                                  color: Colors.blue,
                                  decoration: TextDecoration.underline,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    pushForgotPassword(context);
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
