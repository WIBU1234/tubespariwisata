// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/page/homepage/detailnreview/reviewDestinasiWisata.dart';
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';

class DestinasiWisata extends StatelessWidget {
  const DestinasiWisata({Key? key, required this.destinasi}) : super(key: key);

  final Destinasi destinasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64.decode(destinasi.destinationImage)),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 16, right: 16),
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
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
                  Row(
                    children: [
                      Text(
                        destinasi.destinationName,
                        style: const TextStyle(
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Description",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      // Button review
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReviewDestinasiWisata(
                                destinasi: destinasi,
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
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
                  const SizedBox(height: 5),
                ],
              ),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                  child: SizedBox(
                width: double.infinity,
                child: Text(
                  destinasi.destinationDescription,
                  textAlign: TextAlign.justify,
                ),
              )),
            ),
          ),
        ]),
      ),
    );
  }
}