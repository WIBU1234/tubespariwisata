// IMPORT LIB FROM FLUTTER
import 'dart:convert';
import 'package:flutter/material.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';

class MainGrid extends StatefulWidget {
  const MainGrid({Key? key}) : super(key: key);

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;
  List<Destinasi> destinationList = [];

  @override
  void initState() {
    fetchData();
    super.initState();
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
        });
      });

      ApiDestinasiHelper.getDestinasi().listen((value) {
        setState(() {
          destinationList = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
            width: MediaQuery.of(context).size.width * 0.92,
            height: MediaQuery.of(context).size.height * 0.8,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: SingleChildScrollView(
                child: Column(
                  children: [                    
                    const SizedBox(height: 15),
                    Container(
                      width: 350,
                      height: 110,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200.0,
                            height: 100.0,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 14.0),
                                Text(
                                  "Good Morning,",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 7.0),
                                Text(
                                  "Username",
                                  style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(height: 7.0),
                                Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.all(0),
                                      child: Icon(Icons.location_on_sharp),
                                    ),
                                    Text(
                                      "Yogyakarta, Indonesia",
                                      style: TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 0.0),
                            child: Center(
                              child: CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                  AssetImage("resources/images/bali.jpg"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      width: 350,
                      height: 40,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: Colors.black,
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          const SizedBox(width: 15),
                          const Icon(Icons.search),
                          const SizedBox(width: 5),
                          Text(
                            "Search For Places or Activites",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.normal,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Recommendation",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 350,
                      height: 160,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (var destinasi in destinationList)
                              Padding(
                                padding: const EdgeInsets.only(left: 5, right: 13),
                                child: Container(
                                  width: 100,
                                  height: 160,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white.withOpacity(1.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ticketPage(context, destinasi);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 100,
                                          height: 160,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                              image: MemoryImage(base64.decode(destinasi.destinationImage)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Text(
                      "Nearby Event",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 350,
                      height: 240,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            for (var destinasi in destinationList)
                              Padding(
                                padding: const EdgeInsets.only(top: 5, bottom: 13),
                                child: Container(
                                  width: 350,
                                  height: 95,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                                    color: Colors.white.withOpacity(1.0),
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      ticketPage(context, destinasi);
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          width: 350,
                                          height: 95,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.only(
                                              topLeft: Radius.circular(20),
                                              topRight: Radius.circular(20),
                                              bottomLeft: Radius.circular(20),
                                              bottomRight: Radius.circular(20),
                                            ),
                                            image: DecorationImage(
                                              image: MemoryImage(base64.decode(destinasi.destinationImage)),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
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
        ),
      ),
    );
  }
}