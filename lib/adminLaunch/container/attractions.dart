// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';

class AttractionContainer extends StatefulWidget {
  const AttractionContainer({Key? key, this.destinasiList}) : super(key: key);

  final List<Destinasi>? destinasiList;

  @override
  State<AttractionContainer> createState() => _AttractionContainerState();
}

class _AttractionContainerState extends State<AttractionContainer> {
  List<Destinasi> destinasiList = [];

  @override
  void initState() {
    setForce();
    super.initState();
  }

  void setForce() {
    ApiDestinasiHelper.getDestinasi().listen((destinasis) {
      setState(() {
        destinasiList = destinasis;
      });
    }, onError: (error) {
      print('Error fetching data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: screenHeight * 0.09),
        child: Center(
          child: Container(
            width: screenWidth * 0.9,
            height: screenHeight * 0.839,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            child: Padding(
              padding: EdgeInsets.all(screenWidth * 0.05),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: screenWidth * 0.76,
                      height: screenHeight * 0.68,
                      // color: Colors.black,

                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.68,
                        padding: EdgeInsets.all(screenWidth * 0.001),
                        mainAxisSpacing: 20.0,
                        crossAxisSpacing: 20.0,
                        children: [
                          for (var destinasi in destinasiList)
                            Padding(
                              padding: const EdgeInsets.only(left: 0, right: 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(20)),
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
                                      width: screenWidth * 0.35,
                                      height: screenHeight * 0.16,
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20),
                                        ),
                                        image: DecorationImage(
                                          image:
                                              //AssetImage("resources/images/bali.jpg"),
                                              MemoryImage(base64.decode(destinasi.destinationImage)),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.only(
                                              left: screenWidth * 0.02),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              destinasi.destinationName,
                                              style: TextStyle(
                                                fontSize: screenWidth * 0.034,
                                                fontWeight: FontWeight.normal,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                        ),
                                        // Padding(
                                        //   padding: EdgeInsets.only(
                                        //       left: screenWidth * 0.02),
                                        //   child: Align(
                                        //     alignment: Alignment.centerLeft,
                                        //     child: Text(
                                        //       "Rp. 50.000",
                                        //       style: TextStyle(
                                        //         fontSize: screenWidth * 0.03,
                                        //         fontWeight: FontWeight.normal,
                                        //         color: Colors.black,
                                        //       ),
                                        //     ),
                                        //   ),
                                        // ),
                                      ],
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    GestureDetector(
                                      onTap: () {
                                        // ticketPage(context, destinasi);
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              updateDestinasi(
                                                  context, destinasi);
                                              setForce();
                                            },
                                            child: Container(
                                              width: screenWidth * 0.07,
                                              height: screenWidth * 0.07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth * 0.035),
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
                                              child: Icon(
                                                Icons.update,
                                                size: screenWidth * 0.054,
                                                color: Colors.black,
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () async {
                                              setState(() {
                                                destinasiList.remove(destinasi);
                                              });



                                              // await ApiDestinasiHelper
                                              //     .deleteDestinasi(
                                              //         destinasi.id!);
                                              // setForce();
                                            },
                                            child: Container(
                                              width: screenWidth * 0.07,
                                              height: screenWidth * 0.07,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        screenWidth * 0.035),
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
                                              child: Icon(
                                                Icons.delete,
                                                size: screenWidth * 0.054,
                                                color: Colors.black,
                                              ),
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
                    SizedBox(height: screenHeight * 0.024),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Expanded(
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 6,
                            ),
                            onPressed: () {
                              addDestination(context);
                            },
                            child: Text(
                              'Create',
                              style: TextStyle(fontSize: screenWidth * 0.05),
                            ),
                          ),
                        // ),
                        // Expanded(
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.05,
                                  vertical: screenHeight * 0.02),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 6,
                            ),
                            onPressed: () {
                              setForce();
                              ApiDestinasiHelper.printAll(destinasiList);
                            },
                            child: Text(
                              'Refresh',
                              style: TextStyle(fontSize: screenWidth * 0.05),
                            ),
                          ),
                        // ),
                      ],
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
