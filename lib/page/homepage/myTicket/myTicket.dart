// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/ticket.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/book.dart';

import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/ticketFunction.dart';
// FORCE LAUNCH
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class MyTicket extends StatefulWidget {
  const MyTicket({Key? key}) : super(key: key);

  @override
  State<MyTicket> createState() => MyTicketState();
}

class MyTicketState extends State<MyTicket> {
  String? userId;
  User? userTemp, userTemp2;
  bool isLoading = true;
  Destinasi? destinasiTemp;
  Ticket? ticketTemp;
  List<Ticket> ticketList = [];
  List<Book> bookList = [];

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
        userId = userID;
      });

      loginRegisHelper.loginById(id: int.parse(userID)).then((value) {
        setState(() {
          userTemp = value;
          isLoading = false;
        });
      });

      ApiTicketHelper.getTicketStream(id: int.parse(userID)).listen((value) {
        setState(() {
          bookList = value;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("resources/images/bali.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: isLoading
            ? const CircularProgressIndicator()
            : Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: Center(
                  child: Container(
                    width: 330,
                    height: 610,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white.withOpacity(0.8),
                    ),
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Center(
                          child: Container(
                            width: 300,
                            height: 580,

                            // Add your content here SINI WOI
                            child: Column(

                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        popper(context);
                                      },

                                      child: const Padding(
                                        padding: EdgeInsets.only(top: 20, left: 20),
                                        child: Icon(Icons.keyboard_arrow_left, size: 30.0),
                                      ),
                                    ),

                                    const Center(
                                      child: Padding(
                                        padding: EdgeInsets.only(top: 20, left: 0),
                                        child: Text(
                                          "Your purchase list",
                                          style: TextStyle(
                                            fontSize: 20,
                                            // fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                const SizedBox(height: 20),
                                Container(
                                  width: 280,
                                  height: 500,
                                  // color: Colors.black,

                                  child: GridView.count(
                                  crossAxisCount: 1,
                                  childAspectRatio: 2.6,
                                  padding: const EdgeInsets.all(2),
                                  mainAxisSpacing: 20.0,
                                  crossAxisSpacing: 20.0,
                                  children:  [
                                    
                                    for(var book in bookList) 
                                      FutureBuilder<Destinasi>(
                                        future: ApiDestinasiHelper.getDestinasiById(book.idDestinasi),
                                        builder: (BuildContext context, AsyncSnapshot<Destinasi> snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return const CircularProgressIndicator();
                                          } else if (snapshot.hasError) {
                                            return Text('Error: ${snapshot.error}');
                                          } else if (snapshot.hasData) {
                                            var destinasiTemp = snapshot.data;

                                            return FutureBuilder<Ticket>(
                                              future: ApiTicketHelper.getTicketById(book.idTicket),
                                              builder: (BuildContext context, AsyncSnapshot<Ticket> snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const CircularProgressIndicator();
                                                } else if (snapshot.hasError) {
                                                  return Text('Error: ${snapshot.error}');
                                                } else if (snapshot.hasData) {
                                                  var ticketTemp = snapshot.data;

                                                  return Padding(
                                                    padding: const EdgeInsets.only(left: 0, right: 0),
                                                    child: Container(
                                                      width: 380,
                                                      decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius: BorderRadius.circular(10),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            color: Colors.black12,
                                                            spreadRadius: 1,
                                                            blurRadius: 10,
                                                            offset: Offset(0, 4),
                                                          ),
                                                        ],
                                                      ),

                                                      child: Row(
                                                        children: [
                                                          Container(
                                                            width: 100,
                                                            height: 120,
                                                            decoration: BoxDecoration(
                                                              borderRadius: BorderRadius.circular(20),
                                                              image: DecorationImage(
                                                                image: MemoryImage(base64.decode(destinasiTemp!.destinationImage)),
                                                                fit: BoxFit.fill,
                                                              ),
                                                            ),
                                                          ),

                                                          const SizedBox(width: 12),
                                                          Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              const SizedBox(height: 12),
                                                              Text(
                                                                ticketTemp!.ticketName,
                                                                style: const TextStyle(
                                                                  fontWeight: FontWeight.w500,
                                                                ),
                                                              ),

                                                              const SizedBox(height: 6),
                                                              Align(
                                                                alignment: Alignment.centerLeft,
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 0),
                                                                  child: Text(
                                                                    book.dateofDeparture,
                                                                    style: const TextStyle(
                                                                      fontWeight: FontWeight.w300,
                                                                      fontSize: 12,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),

                                                              const SizedBox(height: 26),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets.only(left: 0),
                                                                  child: Container(
                                                                    width: 100,
                                                                    height: 20,
                                                                    decoration: BoxDecoration(
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      color: Colors.grey[300],
                                                                    ),
                                                                    child: GestureDetector(
                                                                      onTap: () {
                                                                        detailPageTicket(context, book);
                                                                      },
                                                              
                                                                      child: const Row(
                                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                                        children: [
                                                                          Padding(
                                                                            padding: EdgeInsets.only(left: 5),
                                                                            child: Text(
                                                                              "See Ticket",
                                                                              style: TextStyle(
                                                                                fontSize: 12,
                                                                                fontWeight: FontWeight.w300,
                                                                              ),
                                                                            ),
                                                                          ),
                                                              
                                                                          Padding(
                                                                            padding: EdgeInsets.only(left: 5),
                                                                            child: Icon(Icons.arrow_forward_ios, size: 12.0),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    )
                                                                    
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return const Text('No data V2');
                                                }
                                              },
                                            );
                                          } else {
                                            return const Text('No data');
                                          }
                                        },
                                      ),

                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );    
  }
}