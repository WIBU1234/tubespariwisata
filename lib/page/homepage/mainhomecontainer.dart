// IMPORT LIB FROM FLUTTER
// import 'dart:math';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:qr_flutter/qr_flutter.dart';
// import 'package:tubespariwisata/data/wisata.dart';
import 'package:sensors/sensors.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
// import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;
  List<Destinasi> destinationList = [];

  @override
  void initState() {
    fetchData();


    accelerometerEvents.listen((event) {
      if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
        setState(() {
          isMenuVisible = !isMenuVisible;
        });
      }
    });

    getDestinasiAll().listen((destinasi) {
      setState(() {
        destinationList = destinasi;
      });
    });

    super.initState();
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
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: Column(
                children: [
                  const SizedBox(height: 30),
                  Container(
                    width: 290,
                    height: 50,
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
            
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 130,
                        height: 50,

                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Explore Activities in",
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),

                            Text(
                              "Yogyakarta",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        // color: Colors.black,
                      ),
            
                      Container(
                        width: 130,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.black,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(width: 10),
                            SizedBox(
                              child: Center(
                                child: Icon(
                                  Icons.search,
                                  size: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),

                            SizedBox(width: 2),
                            Text(
                              "See Other Destination",
                              style: TextStyle(
                                fontSize: 9,
                                fontWeight: FontWeight.normal,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),
                  Container(
                    width: 280,
                    height: 80,

                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Center(
                                child: Icon(
                                  Icons.attractions_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),
                            Text(
                              "Attractions",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Center(
                                child: Icon(
                                  Icons.tour_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),
                            Text(
                              "Tours",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Center(
                                child: Icon(
                                  Icons.cruelty_free_outlined,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),
                            Text(
                              "Culture",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),

                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              child: Center(
                                child: Icon(
                                  Icons.food_bank,
                                  size: 40,
                                  color: Colors.black,
                                ),
                              ),
                            ),

                            SizedBox(height: 8),
                            Text(
                              "Culinary",
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.only(right: 0, left: 0),
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

                  const SizedBox(height: 18),
                  Container(
                    width: 280,
                    height: 300,

                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.7,
                      padding: const EdgeInsets.all(1.0),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,

                      children: [
                        for(var destinasi in destinationList)
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
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
                    
                            child: Column(
                              children: [
                                Container(
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: MemoryImage(base64.decode(destinasi.destinationImage)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                    
                                const SizedBox(height: 8),
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          destinasi.destinationName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                    
                                    const Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Rp. 50.000",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    
                                const SizedBox(height: 8),
                                Container(
                                  width: 80,
                                  height: 14,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey[350],
                                    boxShadow: const [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 2,
                                        blurRadius: 14,
                                        offset: Offset(0, 9),
                                      ),
                                    ],
                                  ),
                    
                                  child: const Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: 6),
                                      SizedBox(
                                        child: Center(
                                          child: Icon(
                                            Icons.keyboard_arrow_down_outlined,
                                            size: 14,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                    
                                      SizedBox(width: 2),
                                      Text(
                                          "See Tickets",
                                          style: TextStyle(
                                            fontSize: 8,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                      ),
                    
                                    ],
                                  ),
                    
                                ),
                    
                              ],
                            ),
                    
                          ),
                        ),
                      ],

                    ),
                  ),
                ],

                // child: isMenuVisible
                //     ? GestureDetector(
                //         onTap: () {
                //           pushScanQr(context);
                //         },
                //         child: Container(
                //           width: 250,
                //           height: 320,
                //           decoration: BoxDecoration(
                //             borderRadius: BorderRadius.circular(20),
                //             color: Colors.white.withOpacity(0.5),
                //             border: Border.all(
                //               color: Colors.black.withOpacity(0.3),
                //               width: 1,
                //             ),
                //           ),
                //           child: Column(
                //             // mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               const SizedBox(height: 30),
                //               const Text(
                //                 "Suprise Me !!",
                //                 style: TextStyle(
                //                   fontSize: 24,
                //                   fontWeight: FontWeight.bold,
                //                 ),
                //               ),
                //               const SizedBox(height: 10),
                //               SizedBox(
                //                 width: 220,
                //                 height: 220,
                //                 child: QrImageView(
                //                   data: Random().nextInt(daftarWisata.length).toString(),
                //                   size: 220,
                //                   version: QrVersions.auto,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       )
                //     : Container(),

              ),
            ),
          ),
        ),
      ),
    );
  }
}