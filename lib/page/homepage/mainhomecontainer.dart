// IMPORT LIB FROM FLUTTER
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:tubespariwisata/data/wisata.dart';
import 'package:sensors/sensors.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;

  @override
  void initState() {
    fetchData();
    super.initState();

    accelerometerEvents.listen((event) {
      if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
        setState(() {
          isMenuVisible = !isMenuVisible;
        });
      }
    });

  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      searchUserByShared(userID).then((value) {
        setState(() {
          userTemp = value;
        });
      });
    }
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
            child: Center(
              child: isMenuVisible
                  ? GestureDetector(
                      onTap: () {
                        pushScanQr(context);
                      },
                      child: Container(
                        width: 250,
                        height: 320,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white.withOpacity(0.5),
                          border: Border.all(
                            color: Colors.black.withOpacity(0.3),
                            width: 1,
                          ),
                        ),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 30),
                            const Text(
                              "Suprise Me !!",
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: 220,
                              height: 220,
                              child: QrImageView(
                                data: Random().nextInt(daftarWisata.length).toString(),
                                size: 220,
                                version: QrVersions.auto,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : Container(),
            ),
          ),
        ),
      ),
    );
  }

}