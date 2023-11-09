// IMPORT LIB FROM FLUTTER
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tubespariwisata/data/wisata.dart';
import 'package:sensors/sensors.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

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

                  const SizedBox(height: 16),
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
                    padding: const EdgeInsets.only(right: 10, left: 10),
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