// FLUTTER LIB MATERIAL
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

// FIRST PAGE LAUNCHER
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  navigateTo(BuildContext context, String routeName) => Navigator.pushNamed(context, routeName);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const Loginpage(),
    );
  }
}
