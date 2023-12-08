// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/review.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiReviewFunction.dart';
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';

class UpdateReviewDestinasiWisata extends StatefulWidget {
  const UpdateReviewDestinasiWisata({Key? key, required this.destinasi, required this.review})
      : super(key: key);

  final Destinasi destinasi;
  final Review review;

  @override
  State<UpdateReviewDestinasiWisata> createState() => _UpdateReviewDestinasiWisataState();
}

class _UpdateReviewDestinasiWisataState extends State<UpdateReviewDestinasiWisata> {
  String? userId;
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerReview = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    String? userID = await getUserID();
  
    if (userID != null) {
      setState(() {
        userId = userID;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 220,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: MemoryImage(base64.decode(widget.destinasi.destinationImage)),
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
                      for (int i = 0; i < widget.destinasi.destinationRating; i++)
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
          Form(
            key: _formKey,
            child: Expanded(
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
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: TextFormField(
                        controller: controllerReview,
                        minLines: 10,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Write your review here',
                        ),
                        maxLines: null,
                        keyboardType: TextInputType.multiline,
                        validator: (value) {
                          if(value == ''){
                            return 'Please fill the review';
                          }
                          return null;
                        }
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        if(!_formKey.currentState!.validate()){

                        }else{
                          if (userId != null && widget.destinasi.id != null) {
                            ApiDestinasiHelper.updateReview(
                              id: widget.review.id!,
                              idUser: int.parse(userId!),
                              idDestinasi: widget.destinasi.id!,
                              review: controllerReview.text,
                              rating: 0);

                            popperToRoot(context);
                            pushHomePage(context);
                          }
                        }
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
                          "Edit Review",
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
          ),
        ]),
      ),
    );
  }
}