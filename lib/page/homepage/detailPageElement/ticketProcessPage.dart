// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key, required this.destinasi}) : super(key: key);

  final Destinasi destinasi;

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("resources/images/bali.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          
          child: Column(
            children: [
              Container(
                width: 360,
                height: 230,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: MemoryImage(base64.decode(widget.destinasi.destinationImage)),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
          
              Container(
                width: 360,
                height: 506,
                color: Colors.white,
          
                child: Padding(
                  padding: const EdgeInsets.all(20),
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Borobudur Temple",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
          
                          Container(
                            width: 90,
                            height: 32,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                            ),
          
                            child: const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Learn More",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
          
                      const SizedBox(height: 6),
                      for(var i=0; i<widget.destinasi.destinationRating; i++)
                        const Row(
                          children: [
                            Icon(
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
                            widget.destinasi.destinationAddress,
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Ticket Category",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),  

                      Column(
                        children: [
                          for(int i=0; i<3; i++)
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                            child: Container(
                              width: 340,
                              height: 80,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: Colors.black.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),

                              child: Padding(
                                padding: const EdgeInsets.only(top: 10, bottom: 10, right: 5, left: 5),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "Premium High Class Quality Ticket",
                                        style: TextStyle(
                                          fontSize: 17,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          width: 86,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Available",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 2),
                                        Container(
                                          width: 90,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Buy Ticket",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(width: 2),
                                        Container(
                                          width: 86,
                                          height: 34,
                                          decoration: BoxDecoration(
                                            borderRadius: const BorderRadius.all(Radius.circular(6)),
                                            border: Border.all(
                                              color: Colors.black,
                                              width: 1,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Text(
                                              "Rp150.000",
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                              ),
                                            ),
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
                    ],
                  ),
                ),
              ),
          
            ]
          ),
        ),
      ),
    );
  }
}