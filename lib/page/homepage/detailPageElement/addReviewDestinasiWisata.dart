// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiReviewFunction.dart';
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';

import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';

// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
class AddReviewDestinasiWisata extends StatefulWidget {
  final Destinasi destinasi;
  const AddReviewDestinasiWisata({Key? key, required this.destinasi})
      : super(key: key);

  @override
  State<AddReviewDestinasiWisata> createState() =>
      _AddReviewDestinasiWisataState();
}

class _AddReviewDestinasiWisataState extends State<AddReviewDestinasiWisata> {
  String? tempid;
  User? userTemp;
  int? idDestinasi;
  TextEditingController controllerReview = TextEditingController();
  TextEditingController controllerRating = TextEditingController();

  @override
  void initState() {
    fetchImidiately();
    super.initState();
  }

  void fetchImidiately() {
    fetchData();
  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        tempid = userID;
      });

      loginRegisHelper.loginById(id: int.parse(userID)).then((value) {
        setState(() {
          userTemp = value;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    idDestinasi = widget.destinasi.id;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tambah Review"),
      ),
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(
                    base64.decode(widget.destinasi.destinationImage)),
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
                        widget.destinasi.destinationName,
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
                      for (int i = 0;
                          i < widget.destinasi.destinationRating;
                          i++)
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
                        widget.destinasi.destinationAddress,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 25),
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
                child: Column(children: [
                  const SizedBox(
                    width: double.infinity,
                    child: Text(
                      "What do you think?",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  TextFormField(
                      controller: controllerReview,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        labelText: 'Review',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.022),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Review must be filled';
                        }
                        return null;
                      }),
                  const SizedBox(height: 10),
                  TextFormField(
                      controller: controllerRating,
                      decoration: InputDecoration(
                        prefixIcon: const Icon(Icons.location_city),
                        labelText: 'Rating',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(50),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                            vertical: screenHeight * 0.022),
                      ),
                      validator: (value) {
                        if (value == '') {
                          return 'Rating';
                        } else if (numberException() == 0) {
                          return 'Rating must be number';
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    width: double.infinity,
                    child: TextField(
                      minLines: 10,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Write your review here',
                      ),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () {
                      ApiReviewHelper.createReview(
                        idUser: int.parse(tempid!),
                        idDestinasi: idDestinasi!,
                        review: controllerReview.text,
                        rating: int.parse(controllerRating.text),
                      );
                      Navigator.pop(context);
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
                        "Tambah Review",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                ]),
              )),
            ),
          ),
        ]),
      ),
    );
  }

  int numberException() {
    try {
      int number = int.parse(controllerRating.text);
      return 1;
    } catch (e) {
      return 0;
    }
  }
}
