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
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
// IMPORTER PAGE LAUNCHER
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class AllPage extends StatefulWidget {
  const AllPage({Key? key, required this.destinasi}) : super(key: key);

  final Destinasi destinasi;

  @override
  State<AllPage> createState() => _AllPageState();
}

class _AllPageState extends State<AllPage> {
  List<Destinasi> destinasiTemp = [];
  List<Ticket> listTicket = [];
  bool isLoading = true;
  String? userId;
  User? userTemp;

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

      loginRegisHelper.loginById(id: int.parse(userId!)).then((value) {
        setState(() {
          userTemp = value;
        });
      });

      ApiTicketHelper.getTicketByIdDestinasi(widget.destinasi.id!).listen((value) {
        setState(() {
          listTicket = value;
          isLoading = false;
        });
      });
    }
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
          
              Container(
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
                          for(var ticket in listTicket)
                          GestureDetector(
                            onTap: () {
                              if(ticket.status == "sold out") {
                                componentSnackAlert.snackBarError(context, "Ticket was sold out");
                              } else {
                                componentSnackAlert.snackBarSuccess(context, "Let's start filling your vacation days");
                                buyTicketProcess(context, widget.destinasi, ticket, userTemp!);
                              }
                            },

                            child: Padding(
                              padding: const EdgeInsets.only(left: 16, right: 16, top: 6),
                              child: Container(
                                width: 340,
                                height: 80,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
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
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          ticket.ticketName,
                                          style: const TextStyle(
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
                                            child: Center(
                                              child: Text(
                                                ticket.status,
                                                style: const TextStyle(
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
                                            child: Center(
                                              child: Text(
                                                ticket.status == "sold out" ? "Out of Stock" : "Buy Ticket",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
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
                                            child: Center(
                                              child: Text(
                                                "Rp ${ticket.price.toString()}",
                                                style: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
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