// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:tubespariwisata/component/customSnackAlert.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/destinasi.dart';
import 'package:tubespariwisata/entity/ticket.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/book.dart';

class BuyTicketPage extends StatefulWidget {
  const BuyTicketPage({Key? key, required this.destinasi, required this.user, required this.ticket}) : super(key: key);

  final Destinasi destinasi;
  final User user;
  final Ticket ticket;

  @override
  State<BuyTicketPage> createState() => _BuyTicketPageState();
}

class _BuyTicketPageState extends State<BuyTicketPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerDateDeparture = TextEditingController();
  TextEditingController controllerDateReturn = TextEditingController();

  TextEditingController numberofTicket = TextEditingController();
  TextEditingController priceofTicket = TextEditingController();

  Book? newBook;

  @override
  void initState() {
    double ticketPrice = widget.ticket.price;
    int numOfTickets = 0;

    numberofTicket.addListener(() {
      setState(() {
        int numOfTickets = int.tryParse(numberofTicket.text) ?? 0;
        priceofTicket.text = (numOfTickets * widget.ticket.price).toString();
      });
    });

    priceofTicket.text = (numOfTickets * ticketPrice).toString();

    super.initState();
  }

  Future<void> dateDeparture() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        controllerDateDeparture.text = DateFormat('yyyy-MM-dd').format(picked).toString().split(" ")[0];
      });
    }
  }

  Future<void> dateReturn() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(3000),
    );

    if (picked != null) {
      setState(() {
        controllerDateReturn.text = DateFormat('yyyy-MM-dd').format(picked).toString().split(" ")[0];
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
          
          child: SingleChildScrollView(
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
                
                          const SizedBox(height: 10),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                              Form(
                                key: _formKey,
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                                  child: Container(
                                    // height: 200,
                                    // color: Colors.black,
                              
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Date of Return",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: TextFormField(
                                                controller: controllerDateDeparture,
                                                onTap: dateDeparture,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(Icons.date_range),
                                                  labelText: 'Date of Departure',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                                ),
                                                validator: (value) {
                                                  if(value == ''){
                                                    return 'Please enter your date of departure';
                                                  }
                                                  return null;
                                                }
                                              ),
                                            ),
                                          ],
                                        ),
                            
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Date of Return",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: TextFormField(
                                                controller: controllerDateReturn,
                                                onTap: dateReturn,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(Icons.date_range),
                                                  labelText: 'Date of Return',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                                ),
                                                validator: (value) {
                                                  if(value == ''){
                                                    return 'Please enter your date of return';
                                                  }
                                                  return null;
                                                }
                                              ),
                                            ),
                                          ],
                                        ),
                            
                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Number of Ticket",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: 
                                              TextFormField(
                                                keyboardType: TextInputType.number,
                                                controller: numberofTicket,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(Icons.calculate),
                                                  labelText: 'Number of Ticket',
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                                ),
                                                validator: (value) {
                                                  if(value == ''){
                                                    return 'Please enter how much';
                                                  }
                                                  return null;
                                                }
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: 140,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: Text(
                                                    "Price for each ticket",
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.normal,
                                                      color: Colors.black,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 10,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: const Center(
                                                child: Text(
                                                  ":",
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.normal,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ),
                                            ),
                                            Container(
                                              width: 170,
                                              height: 40,
                                              // color: Colors.amber,
                                              child: TextFormField(
                                                keyboardType: TextInputType.number,
                                                enabled: false,
                                                decoration: InputDecoration(
                                                  prefixIcon: const Icon(Icons.calculate),
                                                  labelText: widget.ticket.price.toString(),
                                                  border: OutlineInputBorder(
                                                    borderRadius: BorderRadius.circular(10),
                                                  ),
                                                  contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                                ),
                                                // validator: (value) {
                                                //   if(value == ''){
                                                //     return '';
                                                //   }
                                                //   return null;
                                                // }
                                              ),
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),
                                        Container(
                                          decoration: const BoxDecoration(
                                            border: Border(
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 1.0,
                                              ),
                                            ),
                                          ),
                                        ),

                                        const SizedBox(height: 12),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green,
                                            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            elevation: 6,
                                          ),
                                          onPressed: () {
                                            if (!_formKey.currentState!.validate()) {
                                              componentSnackAlert.snackBarError(context, "Please fill all of the avaible field");
                                            } else {
                                              componentSnackAlert.snackBarSuccess(context, "Yeayyy it's time to pay");

                                              newBook = Book(idUser: widget.user.id!, 
                                                idDestinasi: widget.destinasi.id!,
                                                idTicket: widget.ticket.id!,
                                                nomorResi: "",
                                                dateofDeparture: controllerDateDeparture.text, 
                                                dateofReturn: controllerDateReturn.text);

                                              payTicketProcess(context, newBook!, widget.destinasi, int.tryParse(numberofTicket.text) ?? 0);
                                            }
                                          },
                                          child: const Text(
                                            'Proceed To Payment', style: TextStyle(fontSize: 18),
                                          ),
                                        ),

                                      ],
                                    ),
                              
                                  ),
                                ),
                              ),
                              ],
          
                            ),
                          )
                
                        ],
                      ),
                    ),
                  ),
                ),
            
              ]
            ),
          ),
        ),
      ),
    );
  }
}