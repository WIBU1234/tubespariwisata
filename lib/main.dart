// FLUTTER LIB MATERIAL
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// FIRST PAGE LAUNCHER
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';
import 'package:tubespariwisata/page/homepage/homepage.dart';
import 'package:tubespariwisata/adminLaunch/pageAdmin/addDestination.dart';
// FUNCTION LAUNCHER
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

@override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, deviceType) {
        Device.orientation == Orientation.portrait
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
        Device.screenType == ScreenType.tablet
            ? Container(
                width: 100.w,
                height: 20.5.h,
              )
            : Container(
                width: 100.w,
                height: 12.5.h,
              );
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
                if (snapshot.data!.toLowerCase().contains("admin")) {
                  return const MaterialApp(
                    home: AddMain(),
                  );
                } else {
                  return const MaterialApp(
                    home: Homepage(),
                  );
                }
              } else {
                return const MaterialApp(
                  home: Loginpage(),
                );
              }
            }
          },
        );
      },
    );
  }
}