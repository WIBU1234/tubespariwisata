// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:tubespariwisata/component/customSnackAlert.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiBookFunction.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/entity/book.dart';
import 'package:tubespariwisata/entity/destinasi.dart';

class PayTicketPage extends StatefulWidget {
  const PayTicketPage({Key? key, required this.book, required this.destinasi, required this.numberTicket}) : super(key: key);

  final Book book;
  final Destinasi destinasi;
  final int numberTicket;

  @override
  State<PayTicketPage> createState() => _PayTicketPageState();
}

class _PayTicketPageState extends State<PayTicketPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerAccountNumber = TextEditingController();
  TextEditingController controllerCVV = TextEditingController();

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
                      child: SingleChildScrollView(
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
                                      
                            const SizedBox(height: 24),
                            const Align(
                              alignment: Alignment.center,
                              child: Text(
                                "Payment",
                                style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),  
                      
                            const SizedBox(height: 8),
                            Form(
                              key: _formKey,
                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: const BoxDecoration(
                                          border: Border(
                                            bottom: BorderSide(
                                              color: Colors.black38,
                                              width: 1.0,
                                            ),
                                          ),
                                        ),
                                      ),
                              
                                      const SizedBox(height: 14),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Your name',
                                          style: TextStyle(
                                            fontSize: 16, 
                                            color: Colors.black),
                                        ),
                                      ),
                              
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: controllerName,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          labelText: 'Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                        ),
                                        validator: (value) {
                                          if(value == ''){
                                            return 'Please enter your name';
                                          }
                                          return null;
                                        }
                                      ),
                              
                                      const SizedBox(height: 14),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'Account Number',
                                          style: TextStyle(
                                            fontSize: 16, 
                                            color: Colors.black),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: controllerAccountNumber,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          labelText: 'Account Number',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                        ),
                                        validator: (value) {
                                          if(value == ''){
                                            return 'Please enter your account number';
                                          }
                                          return null;
                                        }
                                      ),
                              
                                      const SizedBox(height: 14),
                                      const Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          'CVV Number',
                                          style: TextStyle(
                                            fontSize: 16, 
                                            color: Colors.black),
                                        ),
                                      ),
                                      
                                      const SizedBox(height: 12),
                                      TextFormField(
                                        controller: controllerCVV,
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(Icons.person),
                                          labelText: 'CVV',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(16),
                                          ),
                                          contentPadding: const EdgeInsets.symmetric(vertical: 17),
                                        ),
                                        validator: (value) {
                                          if(value == ''){
                                            return 'Please enter your CVV';
                                          }
                                          return null;
                                        }
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
                                            ApiBookHelper.loopNumberofTicket(widget.book, widget.numberTicket);
                                            popperToRoot(context);
                                            pushHomePage(context);
                                          }
                                        },
                                        child: const Text(
                                          'Proceed To Payment', style: TextStyle(fontSize: 18),
                                        ),
                                      ),
                              
                                    ],
                                  )
                                ),
                              ),
                            ),
                          ],
                        ),
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