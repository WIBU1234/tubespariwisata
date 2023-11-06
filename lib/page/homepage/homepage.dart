// IMPORT LIB FROM FLUTTER
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:intl/intl.dart';
import 'package:camera/camera.dart';
import 'package:latlong2/latlong.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';
import 'package:sensors/sensors.dart';
import 'package:tubespariwisata/data/wisata.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// IMPORT FORCE PAGE
import 'package:tubespariwisata/hardware/camera.dart';
import 'package:tubespariwisata/page/homepage/card_detail_page.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  var _selectedTab = _SelectedTab.home;
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;

  @override
  void initState() {
    fetchData();
    super.initState();

    accelerometerEvents.listen((event) {
      if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
        setState(() {
          isMenuVisible = !isMenuVisible;
        });
      }
    });
  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      searchUserByShared(userID).then((value) {
        setState(() {
          userTemp = value;
        });
      });
    }
  }

  Widget _getSelectedScreen() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return _buildHomeContainer();
      case _SelectedTab.person:
        return _buildPersonContainer();
      case _SelectedTab.search:
        return _buildSearchContainer();
      case _SelectedTab.settings:
        return _buildSettingsContainer();
    }
  }

  // HOME CONTAINER
  Widget _buildHomeContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
            //child: const Text('Home Screen'),

            child: Center(
              child: isMenuVisible
                  ? GestureDetector(
                      onTap: () {
                        pushScanQr(context);
                      },
                      child: Container(
                        width: 250,
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              "Suprise Me !!",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: QrImageView(
                                data: Random().nextInt(daftarWisata.length).toString(),
                                size: 220,
                                version: QrVersions.auto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

  // PROFILE CONTAINER
  Widget _buildPersonContainer() {
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

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50), // Adjust the top value as needed
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
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
                        const Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
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
                                  await availableCameras().then((value) => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              CameraPage(cameras: value, user: userTemp!))));
                                },
                                child: Center(
                                  // child: widget.picture != null
                                  child: userTemp!.imageFoto != ""
                                      ? ClipOval(
                                          child: Image.memory(
                                              Uint8List.fromList(
                                                  base64.decode(userTemp!.imageFoto)),
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
                          padding: const EdgeInsets.only(right: 30, left: 30),
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
                                        prefixIcon: const Icon(Icons.person),
                                        labelText: userTemp!.username,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
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
                                        prefixIcon: const Icon(Icons.mail),
                                        labelText: userTemp!.email,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
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
                                        prefixIcon: const Icon(Icons.lock),
                                        labelText: userTemp!.password,
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
                                      keyboardType: TextInputType.number,
                                      controller: controllerNomorTelepon,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.phone),
                                        labelText: userTemp!.nomorTelepon,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
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
                                      controller: controllerTanggalLahir,
                                      onTap: selectDate,
                                      enabled: false,
                                      decoration: InputDecoration(
                                        prefixIcon: const Icon(Icons.date_range),
                                        labelText: userTemp!.tanggalLahir,
                                        border: OutlineInputBorder(
                                          borderRadius: BorderRadius.circular(50),
                                        ),
                                        contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                      ),
                                      validator: (value) {
                                        if (value == '') {
                                          return 'Please enter your date of birth';
                                        }
                                        return null;
                                      }),
                                  const SizedBox(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.green,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 6,
                                        ),
                                        onPressed: () {
                                          pushUpdateProfile(context, userTemp!);
                                        },
                                        child: const Text(
                                          'Update',
                                          style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.red,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 30, vertical: 16),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          elevation: 6,
                                        ),
                                        onPressed: () {
                                          // pushHomePage(context, userTemp);
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(fontSize: 18),
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
    );
  }

  // GRID ITEM CONTAINER
  Widget _buildSearchContainer() {
  return Container(
    decoration: const BoxDecoration(
      image: DecorationImage(
        image: AssetImage("resources/images/bali.jpg"),
        fit: BoxFit.cover,
      ),
    ),
    child: Padding(
      padding: const EdgeInsets.only(bottom: 50),
      child: Center(
        child: Container(
          width: 330,
          height: 610,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white.withOpacity(0.8),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetailPage(
                        imagePath: "resources/images/aceh.jpg",
                        cardText: "Masjid Baihturrahman - Aceh",
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: [
                      ClipRect(
                        child: SizedBox(
                          width: 300, // Fixed image width
                          height: 90, // Fixed image height
                          child: Image.asset(
                            "resources/images/aceh.jpg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Masjid Baihturrahman - Aceh",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetailPage(
                        imagePath: "resources/images/yogyakarta.webp",
                        cardText: "Candi Borobudur - Magelang",
                      ),
                    ),
                  );
                },
                
                child: Card(
                  elevation: 4, // Customize card elevation as needed
                  child: Column(
                    children: [
                      ClipRect(
                        child: SizedBox(
                          width: 300, // Fixed image width
                          height: 90, // Fixed image height
                          child: Image.asset(
                            "resources/images/yogyakarta.webp",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Candi Borobudur - Magelang",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onTap: () {
                  // Navigate to the card detail page for Card 1
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CardDetailPage(
                        imagePath: "resources/images/kulonProgo.jpeg",
                        cardText: "Embung Tirta - Kulonprogo",
                      ),
                    ),
                  );
                },
                child: Card(
                  elevation: 4, // Customize card elevation as needed
                  child: Column(
                    children: [
                      ClipRect(
                        child: SizedBox(
                          width: 300, // Fixed image width
                          height: 90, // Fixed image height
                          child: Image.asset(
                            "resources/images/kulonProgo.jpeg",
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Embung Tirta - Kulonprogo",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
  );
}


  // SETTINGS CONTAINER
  Widget _buildSettingsContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 70),
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
            child: Column(
              children: [
                const SizedBox(height: 20),
                Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Center(
                      child: Container(
                        width: 300,
                        height: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: 160.0,
                              height: 100.0,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 14.0),
                                  Text(
                                    "Username",
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 20.0),
                              child: Center(
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage: AssetImage("resources/images/bali.jpg"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )),
                const SizedBox(height: 25),
                const Padding(
                  padding: EdgeInsets.only(left: 30.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Settings",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                InkWell(
                  onTap: () {
                    // Arahkan ke halaman scan
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => ScanPage()),
                    // );
                    pushScanQr(context);
                  },
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.qr_code_scanner_outlined),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            'Scan QR',
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0),
                          child: Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.info),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "About Us",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 80.0),
                          child: Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.security),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Privacy Policy",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 45.0),
                          child: Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.language_sharp),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Language",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 75.0),
                          child: Icon(Icons.arrow_forward_ios_sharp),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: 250,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(60.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.5),
                          spreadRadius: 0,
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 20.0),
                          child: Icon(Icons.logout),
                        ),
                        const Padding(
                          padding: EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Log Out",
                            style: TextStyle(
                              fontSize: 18,
                              // fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              removeUserID();
                              pushLogin(context);
                            });
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 90.0),
                            child: Icon(Icons.arrow_forward_ios_sharp),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _getSelectedScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          splashBorderRadius: 50,
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.menu),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.settings),
              selectedColor: const Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { home, person, search, settings }
