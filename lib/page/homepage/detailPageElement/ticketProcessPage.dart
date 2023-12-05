// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';

class AllPage extends StatelessWidget {
  const AllPage({Key? key, required this.destinasi}) : super(key: key);

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Ticket Process"),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 230,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64.decode(destinasi.destinationImage)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  const Align(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.black,
                      size: 30,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Row(
                    children: [
                      Text(
                        "Borobudur Temple",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      for (int i = 0; i < destinasi.destinationRating; i++)
                        const Icon(
                          Icons.star,
                          color: Colors.black,
                          size: 20,
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.black,
                        size: 20,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        destinasi.destinationAddress,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Ticket Category",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Button review
                      Container(
                        width: 90,
                        height: 34,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(6)),
                          border: Border.all(
                            color: Colors.black,
                            width: 1,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Review",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      destinasi.destinationDescription,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  // Column(
                  //   children: [
                  //     for (int i = 0; i < 3; i++)
                  //       Padding(
                  //         padding: const EdgeInsets.only(
                  //             left: 16, right: 16, top: 6),
                  //         child: Container(
                  //           width: 340,
                  //           height: 80,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(20),
                  //             border: Border.all(
                  //               color: Colors.black.withOpacity(0.2),
                  //               width: 1,
                  //             ),
                  //           ),
                  //           child: Padding(
                  //             padding: const EdgeInsets.only(
                  //                 top: 10, bottom: 10, right: 5, left: 5),
                  //             child: Column(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceBetween,
                  //               children: [
                  //                 const Align(
                  //                   alignment: Alignment.centerLeft,
                  //                   child: Text(
                  //                     "Premium High Class Quality Ticket",
                  //                     style: TextStyle(
                  //                       fontSize: 17,
                  //                       fontWeight: FontWeight.w600,
                  //                       color: Colors.black,
                  //                     ),
                  //                   ),
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     Container(
                  //                       width: 86,
                  //                       height: 34,
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: const BorderRadius.all(
                  //                             Radius.circular(6)),
                  //                         border: Border.all(
                  //                           color: Colors.black,
                  //                           width: 1,
                  //                         ),
                  //                       ),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           "Available",
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 18,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 2),
                  //                     Container(
                  //                       width: 90,
                  //                       height: 34,
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: const BorderRadius.all(
                  //                             Radius.circular(6)),
                  //                         border: Border.all(
                  //                           color: Colors.black,
                  //                           width: 1,
                  //                         ),
                  //                       ),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           "Buy Ticket",
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 18,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                     const SizedBox(width: 2),
                  //                     Container(
                  //                       width: 86,
                  //                       height: 34,
                  //                       decoration: BoxDecoration(
                  //                         borderRadius: const BorderRadius.all(
                  //                             Radius.circular(6)),
                  //                         border: Border.all(
                  //                           color: Colors.black,
                  //                           width: 1,
                  //                         ),
                  //                       ),
                  //                       child: const Center(
                  //                         child: Text(
                  //                           "Rp150.000",
                  //                           style: TextStyle(
                  //                             color: Colors.black,
                  //                             fontSize: 16,
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
