// IMPORT LIB FROM FLUTTER
import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'dart:convert';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiReviewFunction.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/review.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/page/homepage/detailnreview/addReviewDestinasiWisata.dart';
import 'package:tubespariwisata/page/homepage/detailnreview/updateReviewDestinasiWisata.dart';
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';

class ReviewDestinasiWisata extends StatefulWidget {
  const ReviewDestinasiWisata({Key? key, required this.destinasi})
      : super(key: key);

  final Destinasi destinasi;

  @override
  State<ReviewDestinasiWisata> createState() => _ReviewDestinasiWisataState();
}

class _ReviewDestinasiWisataState extends State<ReviewDestinasiWisata> {

  List<Review> reviewList = [];
  User? userTemp;
  Review? reviewTemp;
  String? userId;

  @override
  void initState() {
    super.initState();
    fetchData();
    getReview();
  }

  void fetchData() async {
    String? userID = await getUserID();
  
    if (userID != null) {
      setState(() {
        userId = userID;
      });
    }
  }

  void getReview() {
    ApiDestinasiHelper.getReviewByIdDestinasi(widget.destinasi.id!).listen((value) {
      setState(() {
        reviewList = value;
      });
    });
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
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Review",
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
                              builder: (context) => AddReviewDestinasiWisata(
                                destinasi: widget.destinasi,
                                review: reviewTemp!,
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
                            "Add Review",
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
                child: Column(children: [
                  for (reviewTemp in reviewList)
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12,
                            width: 1,
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              offset: Offset(0, 1),
                              blurRadius: 6,
                            ),
                          ],
                        ),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                const CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage("https://i.pravatar.cc/100"),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  child: Text(
                                    reviewTemp!.review,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: Text(
                                reviewTemp!.rating.toString(),
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              UpdateReviewDestinasiWisata(
                                            destinasi: widget.destinasi,
                                            review: reviewTemp!,
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
                                        "Update Review",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 10),
                                SizedBox(
                                  height: 30,
                                  child: ElevatedButton(
                                    onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (context) => AlertDialog(
                                                  title:
                                                      const Text("Delete Review"),
                                                  content: const Text(
                                                      "Are you sure want to delete this review?"),
                                                  actions: [
                                                    TextButton(
                                                      onPressed: () {
                                                                                                                
                                                      },
                                                      child: const Text("Cancel"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      child: GestureDetector(
                                                        onTap: () {
                                                          ApiDestinasiHelper.deleteReview(reviewTemp!.id!);
                                                          popperToRoot(context);
                                                          pushHomePage(context);
                                                        
                                                        },
                                                        
                                                        child: const Text("Delete")
                                                        ),
                                                    ),
                                                  ],
                                                )
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
                                        "Delete Review",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )
                          ],
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
}