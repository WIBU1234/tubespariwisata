// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:tubespariwisata/entity/destinasi.dart';
import 'dart:convert';
// IMPORT LIB FROM FUNCTION
// import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiDestinasiFunction.dart';

class AttractionContainer extends StatefulWidget {
  const AttractionContainer({Key? key}) : super(key: key);

  @override
  State<AttractionContainer> createState() => _AttractionContainerState();
}

class _AttractionContainerState extends State<AttractionContainer> {
  List<Destinasi> destinasiList = [];

  @override
  void initState() {
    setForce();
    super.initState();
  }

  void setForce(){
      ApiDestinasiHelper.getDestinasi().listen((destinasis) {
      setState(() {
        destinasiList = destinasis;
      });
    }, onError: (error) {
      print('Error fetching data: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 50),
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    width: 280,
                    height: 500,
                    // color: Colors.black,

                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.68,
                      padding: const EdgeInsets.all(1.0),
                      mainAxisSpacing: 20.0,
                      crossAxisSpacing: 20.0,

                      children: [
                        for(var destinasi in destinasiList)
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.all(Radius.circular(20)),
                              color: Colors.white.withOpacity(1.0),
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
                              children: [
                                Container(
                                  width: 150,
                                  height: 120,
                                  decoration: BoxDecoration(
                                    borderRadius: const BorderRadius.only(
                                      topLeft: Radius.circular(20),
                                      topRight: Radius.circular(20),
                                    ),
                                    image: DecorationImage(
                                      image: 
                                      //AssetImage("resources/images/bali.jpg"),
                                      MemoryImage(base64.decode(destinasi.destinationImage)),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                    
                                const SizedBox(height: 8),
                                Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(left: 4.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          destinasi.destinationName,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                    
                                    const Padding(
                                      padding: EdgeInsets.only(left: 4.0),
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Rp. 50.000",
                                          style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.normal,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                    
                                const SizedBox(height: 8),
                                GestureDetector(
                                  onTap: (){
                                    // ticketPage(context, destinasi);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          updateDestinasi(context, destinasi);
                                          setForce();
                                        },
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[350],
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 2,
                                                blurRadius: 14,
                                                offset: Offset(0, 9),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.update,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                      GestureDetector(
                                        onTap: () async {
                                          await ApiDestinasiHelper.deleteDestinasi(destinasi.id!);
                                          setForce();
                                        },
                                        child: Container(
                                          width: 22,
                                          height: 22,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: Colors.grey[350],
                                            boxShadow: const [
                                              BoxShadow(
                                                color: Colors.black12,
                                                spreadRadius: 2,
                                                blurRadius: 14,
                                                offset: Offset(0, 9),
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.delete,
                                            size: 16,
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                    
                              ],
                            ),
                    
                          ),
                        ),
                      ],

                    ),
                  ),
            
                  const SizedBox(height: 14),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          addDestination(context);
                        },
                        child: const Text(
                          'Create',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),

                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 30, vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 6,
                        ),
                        onPressed: () {
                          setForce();
                          ApiDestinasiHelper.printAll(destinasiList);
                        },
                        child: const Text(
                          'Refresh',
                          style: TextStyle(fontSize: 18),
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
    );
  }
}