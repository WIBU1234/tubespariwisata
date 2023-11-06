// FLUTTER MATERIAL
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
// FLUTTER FUNCTION PAGE
import 'dart:ui';
// FLUTTER PAGE LAUNCHER
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// FIREBASE FUNCTION
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
// MODEL IMPORTER
import 'package:tubespariwisata/entity/user.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? superKey}): super(key: superKey);

  @override
  State<RegisterPage> createState() => _InputPageState();
}

class _InputPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerNomorTelepon = TextEditingController();
  TextEditingController controllerTanggalLahir = TextEditingController();
  bool isPasswordVisible = true;
  List<User> userList = [];

  @override
  void initState() {
    super.initState();

    getUser().listen((users) {
      setState(() {
        userList = users;
      });
    });
  }

  Future<void> _selectDate() async {
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
              margin: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        'resources/images/logo.png',
                        width: 150,
                        height: 150,
                      ),
                      const Text(
                        'Registration',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),
                      const Text(
                        'Please enter input your data below',
                        style: TextStyle(
                          fontSize: 16, 
                          color: Colors.grey),
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controllerName,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          labelText: 'Name',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                        ),
                        validator: (value) {
                          if(value == ''){
                            return 'Please enter your name';
                          }
                          if(value == 'admin') {
                            return 'Username admin is not permitted!';
                          }
                          return null;
                        }
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controllerEmail,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.mail),
                          labelText: 'Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                        ),
                        validator: (value) {
                          if(value == ''){
                            return 'Please enter your email';
                          }
                          if(value == 'admin') {
                            return 'Email admin is not permitted!';
                          }
                          return null;
                        }
                      ),
                      
                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controllerPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          labelText: 'Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
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
                              color: isPasswordVisible
                                  ? Colors.grey
                                  : Colors.blue,
                            ),
                          ),
                        ),
                        obscureText: isPasswordVisible,
                        validator: (value) {
                          if(value == ''){
                            return 'Please enter your password';
                          }
                          if(value?.length == 5 || value?.length == 4 || value?.length == 3 || value?.length == 2 || value?.length == 1) {
                            return 'Password is too short!';
                          }
                          return null;
                        }
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        keyboardType: TextInputType.number,
                        controller: controllerNomorTelepon,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.phone),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                        ),
                        validator: (value) {
                          if(value == ''){
                            return 'Please enter your phone number';
                          }
                          if(value == '444') {
                            return 'This number is prohibited';
                          }
                          return null;
                        }
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        controller: controllerTanggalLahir,
                        onTap: _selectDate,
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

                      const SizedBox(height: 28),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) {
                            // Handle validation errors
                          } else {
                            if (isUserInList(userList, controllerEmail.text)) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email is already registered'),
                                ),
                              );
                            } else {
                              createUser(
                                username: controllerName.text,
                                email: controllerEmail.text,
                                password: controllerPassword.text,
                                nomorTelepon: controllerNomorTelepon.text,
                                tanggalLahir: controllerTanggalLahir.text,
                                token: '0',
                              );
                              pushLogin(context);
                            }
                          }
                        },
                        child: const Text(
                          'Register', style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}