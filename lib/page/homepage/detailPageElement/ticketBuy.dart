// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tubespariwisata/component/customSnackAlert.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/ticket.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/ticketFunction.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({Key? key, required this.destinasi, required this.user, required this.ticket}) : super(key: key);

  final Destinasi destinasi;
  final User user;
  final Ticket ticket;

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {

  @override
  void initState() {
    super.initState();
  }

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
          
              SingleChildScrollView(
                child: Container(
                  width: 360,
                  height: 506,
              
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                    border: Border.all(
                      color: Colors.white,
                      width: 1,
                    ),
                  ),
                        
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Icon(
                            Icons.favorite,
                            color: Colors.black,
                            size: 24,
                          ),
                        ),
                        
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              widget.destinasi.destinationName,
                              style: const TextStyle(
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
                                borderRadius: BorderRadius.circular(10),
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
                          Row(
                            children: [
                              for(var i=0; i<widget.destinasi.destinationRating; i++)
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
              
                        const SizedBox(height: 30),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.ticket.ticketName,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),  
              
              
              
                      ],
                    ),
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