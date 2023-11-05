// MODULES IMPORT
import 'package:flutter/material.dart';
import 'package:tubespariwisata/entity/user.dart';

// LAUNCHER VIEW
import 'package:tubespariwisata/page/firstLanding/registerpage.dart';
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';
import 'package:tubespariwisata/page/homepage/homepage.dart';
import 'package:tubespariwisata/page/homepage/updateProfile.dart';

// LAUNCHER HARDWARE
import 'package:tubespariwisata/hardware/camera.dart';

void pushRegister(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
}

void pushLogin(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const Loginpage()));
}

void pushHomePage(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const Homepage()));
}

void pushUpdateProfile(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdatePage()));
}

void pushCameraPage(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage(cameras: null, user: user)));
}