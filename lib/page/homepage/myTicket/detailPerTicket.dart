// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/ticket.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/book.dart';
// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:uuid/uuid.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/ticketFunction.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiBookFunction.dart';
import 'package:tubespariwisata/pdf/pdfTicket_view.dart';
// FORCE LAUNCH
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class MyDetailTicket extends StatefulWidget {
  const MyDetailTicket({Key? key, required this.book}) : super(key: key);

  final Book book;

  @override
  State<MyDetailTicket> createState() => _MyDetailTicketState();
}

class _MyDetailTicketState extends State<MyDetailTicket> {
  String? userId;
  User? userTemp;
  Destinasi? destinasiTemp;
  Ticket? ticketTemp;
  bool isLoading = true;
  String id = const Uuid().v1();

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
        });
      });

      ApiDestinasiHelper.getDestinasiById(widget.book.idDestinasi)
          .then((value) {
        setState(() {
          destinasiTemp = value;
          isLoading = false;
        });
      });

      ApiTicketHelper.getTicketById(widget.book.idTicket).then((value) {
        setState(() {
          ticketTemp = value;
          isLoading = false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = this.isLoading ?? false;
    // final _formKey = GlobalKey<FormState>();
    // double screenWidth = MediaQuery.of(context).size.width;
    // double screenHeight = MediaQuery.of(context).size.height;

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
                    height: 740,
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
                            height: 680,

                            // Add your content here SINI WOI
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        popperToRoot(context);
                                        pushHomePage(context);
                                      },
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 20),
                                        child: Icon(Icons.keyboard_arrow_left,
                                            size: 30.0),
                                      ),
                                    ),
                                    const Center(
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(top: 20, left: 0),
                                        child: Text(
                                          "Details Information",
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
                                  height: 600,
                                  // color: Colors.black,

                                  child: Column(
                                    children: [
                                      Container(
                                        width: 280,
                                        // height: 180,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            const SizedBox(height: 10),
                                            Container(
                                              width: 100,
                                              height: 100,
                                              // color: Colors.black,

                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: const [
                                                  BoxShadow(
                                                    color: Colors.black12,
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    offset: Offset(0, 4),
                                                  ),
                                                ],
                                                image: DecorationImage(
                                                  image: MemoryImage(base64
                                                      .decode(destinasiTemp!
                                                          .destinationImage)),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text(
                                              destinasiTemp!.destinationName,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.w400,
                                                fontSize: 24.0,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Container(
                                                width: 100,
                                                height: 20,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: Colors.grey[300],
                                                ),
                                                child: GestureDetector(
                                                  onTap: () {},
                                                  child: const Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Text(
                                                          "See Ticket",
                                                          style: TextStyle(
                                                            fontSize: 12,
                                                            fontWeight:
                                                                FontWeight.w300,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 5),
                                                        child: Icon(
                                                            Icons
                                                                .arrow_forward_ios,
                                                            size: 12.0),
                                                      ),
                                                    ],
                                                  ),
                                                )),
                                            const SizedBox(height: 10),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Container(
                                        width: 280,
                                        height: 160,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(
                                              color: Colors.black12,
                                              spreadRadius: 1,
                                              blurRadius: 10,
                                              offset: Offset(0, 4),
                                            ),
                                          ],
                                        ),
                                        child: SingleChildScrollView(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 10),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Package Details",
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  ticketTemp!.ticketName,
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  "Validity Period",
                                                  style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 20.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  'Date of Departure :  ${widget.book.dateofDeparture}',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  'Date of Return :  ${widget.book.dateofReturn}',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10.0),
                                                child: Text(
                                                  'Resi :  ${widget.book.nomorResi}',
                                                  style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.normal,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: const Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                SizedBox(height: 10),
                                                Padding(
                                                  padding: EdgeInsets.all(0),
                                                  child: Icon(
                                                      Icons.edit_document,
                                                      size: 60.0),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  'Review',
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w300,
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                ApiBookHelper.deleteDataBooking(
                                                    widget.book.id!);
                                                popperToRoot(context);
                                                pushHomePage(context);
                                              },
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding: EdgeInsets.all(0),
                                                    child: Icon(
                                                        Icons.attach_money,
                                                        size: 60.0),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'Refund',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 10),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 100,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[400],
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              boxShadow: const [
                                                BoxShadow(
                                                  color: Colors.black12,
                                                  spreadRadius: 1,
                                                  blurRadius: 10,
                                                  offset: Offset(0, 4),
                                                ),
                                              ],
                                            ),
                                            child: GestureDetector(
                                              onTap: () {
                                                createPdfDetail(
                                                  widget.book.nomorResi,
                                                  widget.book.dateofDeparture,
                                                  widget.book.dateofReturn,
                                                  id,
                                                  destinasiTemp,
                                                  context,
                                                  userTemp,
                                                  ticketTemp,
                                                );
                                              },
                                              child: const Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  SizedBox(height: 10),
                                                  Padding(
                                                    padding: EdgeInsets.all(0),
                                                    child: Icon(
                                                        Icons.picture_as_pdf,
                                                        size: 60.0),
                                                  ),
                                                  SizedBox(height: 2),
                                                  Text(
                                                    'PDF',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      fontSize: 16.0,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
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
