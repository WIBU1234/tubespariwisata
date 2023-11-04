// FLUTTER LIB MATERIAL
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// FIRST PAGE LAUNCHER
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';
import 'package:tubespariwisata/page/homepage/homepage.dart';
// FUNCTION LAUNCHER
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

@override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: getUserID(),
      builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            ),
          );
        } else {
          if (snapshot.hasData && snapshot.data != null && snapshot.data!.isNotEmpty) {
            return const MaterialApp(
              home: Homepage(),
            );
          } else {
            return const MaterialApp(
              home: Loginpage(),
            );
          }
        }
      },
    );
  }
}