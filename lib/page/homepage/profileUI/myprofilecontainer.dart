// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:intl/intl.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:camera/camera.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
// FORCE LAUNCH
import 'package:tubespariwisata/hardware/camera.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  String? userId;
  User? userTemp, userTemp2;
  bool isLoading = true;

  @override
  void initState() {
    fetchImidiately();
    super.initState();
  }

  void fetchObject() {
    getUserForObject().then((value) {
      setState(() {
        userTemp2 = value;
        isLoading = false;
      });
    });
  }

  void fetchImidiately() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      loginRegisHelper.loginById(id: int.parse(userID)).then((value) {
        setState(() {
          userTemp = value;
          isLoading = false;
        });
      });
    }
  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      loginRegisHelper.loginById(id: int.parse(userID)).then((value) {
        setState(() {
          userTemp = value;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();
    TextEditingController controllerPassword = TextEditingController();
    TextEditingController controllerNomorTelepon = TextEditingController();
    TextEditingController controllerTanggalLahir = TextEditingController();
    bool isPasswordVisible = true;

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

    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("resources/images/bali.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Container(
                    width: 330,
                    height: 610,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 580,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            ),

                            // Add your content here SINI WOI
                            child: Column(
                              children: [
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.arrow_back),
                                      onPressed: () {
                                        popper(context);
                                        pushHomePage(context);
                                      },
                                    ),
                                    const Text(
                                      "My Profile",
                                      style: TextStyle(
                                        fontSize: 35,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: InkWell(
                                        onTap: () async {
                                          await availableCameras().then(
                                              (value) => Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (_) =>
                                                          CameraPage(
                                                              cameras: value,
                                                              user:
                                                                  userTemp!))));
                                        },
                                        child: Center(
                                          // child: widget.picture != null
                                          child: userTemp!.imageFoto != "NOTHAVE"
                                                  ? ClipOval(
                                                      child: Image.memory(
                                                          Uint8List.fromList(base64.decode(userTemp!.imageFoto)),
                                                          fit: BoxFit.cover,
                                                          width: 100,
                                                          height: 100),
                                                    )
                                                  : const Icon(
                                                      Icons.photo_camera,
                                                      color: Colors.white,
                                                      size: 50.0,
                                                    ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      right: 30, left: 30),
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Colors.black,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                SizedBox(
                                    height: 340,
                                    width: 260,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          const SizedBox(height: 24),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Full Name",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                              controller: controllerName,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.person),
                                                labelText: userTemp!.username,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 17),
                                              ),
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Please enter your name';
                                                }
                                                if (value == 'admin') {
                                                  return 'Username admin is not permitted!';
                                                }
                                                return null;
                                              }),
                                          const SizedBox(height: 24),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Email",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                              controller: controllerEmail,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.mail),
                                                labelText: userTemp!.email,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 17),
                                              ),
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Please enter your email';
                                                }
                                                if (value == 'admin') {
                                                  return 'Email admin is not permitted!';
                                                }
                                                return null;
                                              }),
                                          const SizedBox(height: 24),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Password",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                              controller: controllerPassword,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.lock),
                                                labelText: userTemp!.password,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 17),
                                                suffixIcon: IconButton(
                                                  onPressed: () {
                                                    setState(() {
                                                      isPasswordVisible =
                                                          !isPasswordVisible;
                                                    });
                                                  },
                                                  icon: const Icon(
                                                    Icons.visibility_off,
                                                    // TF DEAD CODE
                                                    // isPasswordVisible
                                                    //     ? Icons.visibility_off
                                                    //     : Icons.visibility,
                                                    // color: isPasswordVisible
                                                    //     ? Colors.grey
                                                    //     : Colors.blue,
                                                  ),
                                                ),
                                              ),
                                              obscureText: isPasswordVisible,
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Please enter your password';
                                                }
                                                if (value?.length == 5 ||
                                                    value?.length == 4 ||
                                                    value?.length == 3 ||
                                                    value?.length == 2 ||
                                                    value?.length == 1) {
                                                  return 'Password is too short!';
                                                }
                                                return null;
                                              }),
                                          const SizedBox(height: 24),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Number",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                              keyboardType:
                                                  TextInputType.number,
                                              controller:
                                                  controllerNomorTelepon,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                prefixIcon:
                                                    const Icon(Icons.phone),
                                                labelText:
                                                    userTemp!.nomorTelepon,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 17),
                                              ),
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Please enter your phone number';
                                                }
                                                if (value == '444') {
                                                  return 'This number is prohibited';
                                                }
                                                return null;
                                              }),
                                          const SizedBox(height: 24),
                                          const Padding(
                                            padding: EdgeInsets.only(left: 0.0),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                "Date of Birth",
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.normal,
                                                ),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          TextFormField(
                                              controller:
                                                  controllerTanggalLahir,
                                              onTap: selectDate,
                                              enabled: false,
                                              decoration: InputDecoration(
                                                prefixIcon: const Icon(
                                                    Icons.date_range),
                                                labelText:
                                                    userTemp!.tanggalLahir,
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(50),
                                                ),
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 17),
                                              ),
                                              validator: (value) {
                                                if (value == '') {
                                                  return 'Please enter your date of birth';
                                                }
                                                return null;
                                              }),
                                          const SizedBox(height: 24),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.green,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  elevation: 6,
                                                ),
                                                onPressed: () {
                                                  pushUpdateProfile(
                                                      context, userTemp!);
                                                },
                                                child: const Text(
                                                  'Update',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.red,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 30,
                                                      vertical: 16),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                  elevation: 6,
                                                ),
                                                onPressed: () {
                                                  // pushHomePage(context, userTemp);
                                                },
                                                child: const Text(
                                                  'Delete',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );    
  }
}