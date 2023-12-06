// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
// import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/loginRegisterFunction.dart';
// FORCE LAUNCH

class MyTicket extends StatefulWidget {
  const MyTicket({Key? key}) : super(key: key);

  @override
  State<MyTicket> createState() => MyTicketState();
}

class MyTicketState extends State<MyTicket> {
  String? userId;
  User? userTemp, userTemp2;
  bool isLoading = true;

  @override
  void initState() {
    fetchImidiately();
    super.initState();
  }

  void fetchObject() {
    getUserForObject().then((value) {
      setState(() {
        userTemp2 = value;
        isLoading = false;
      });
    });
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
    }
  }

  @override
  Widget build(BuildContext context) {
    // final _formKey = GlobalKey<FormState>();
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
                                const Row(
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 20, left: 20),
                                      child: Icon(Icons.keyboard_arrow_left, size: 30.0),
                                    ),

                                    Center(
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
                                    children: [
                                      for(var i=0; i<5; i++)
                                      Padding(
                                        padding: const EdgeInsets.only(left: 0, right: 0),
                                        child: Container(
                                          width: 380,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(10), // This gives the box (and its shadow) rounded corners
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
                                                width: 120,
                                                height: 120,
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  image: const DecorationImage(
                                                    image: AssetImage("resources/images/bali.jpg"),
                                                    fit: BoxFit.fill,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(width: 12),
                                              const Column(
                                                children: [

                                                  SizedBox(height: 12),
                                                  Text(
                                                    "Borobudur Temple",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w500,
                                                    ),
                                                  ),

                                                  SizedBox(height: 6),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 0),
                                                    child: Text(
                                                      "12 Desember 2023",
                                                      style: TextStyle(
                                                        fontWeight: FontWeight.w300,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
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
                      ),
                    ),
                  ),
                ),
              ),
      ),
    );    
  }
}