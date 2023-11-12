// MODULES IMPORT
import 'package:flutter/material.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/entity/destinasi.dart';

// LAUNCHER VIEW
import 'package:tubespariwisata/page/firstLanding/registerpage.dart';
import 'package:tubespariwisata/page/firstLanding/loginpage.dart';
import 'package:tubespariwisata/page/homepage/homepage.dart';
import 'package:tubespariwisata/page/homepage/updateProfile.dart';

import 'package:tubespariwisata/adminLaunch/pageAdmin/addDestination.dart';
import 'package:tubespariwisata/adminLaunch/container/addDestionation/createDestination.dart';

// LAUNCHER PAGE TO PAY
import 'package:tubespariwisata/page/homepage/detailPageElement/ticketProcessPage.dart';

// LAUNCHER HARDWARE
import 'package:tubespariwisata/hardware/camera.dart';
import 'package:tubespariwisata/hardware/scanqr.dart';

// USER FUNCTION
void pushRegister(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterPage()));
}

void pushLogin(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const Loginpage()));
}

void pushHomePage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const Homepage()));
}

void pushUpdateProfile(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const UpdatePage()));
}

void pushCameraPage(BuildContext context, User user) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => CameraPage(cameras: null, user: user)));
}

void pushScanQr(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const BarcodeScannerPageView()));
}

void ticketPage(BuildContext context, Destinasi destinasi) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => AllPage(destinasi: destinasi)));
}

// ADMIN FUNCTION
void pushAdminHomePage(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const AddMain()));
}

void addDestination(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => const CreatePage()));
}

// CONSTANT
class LabelTextConstant{
  static const String homePageAppBarTitle = "Modul QR, Camera, Scanner";
  static const String scanQrPlaceHolderLabel = "Scanf something & click to copy to clipboard";
  static const String txtonCopyingClipBoard = "QR code disaling ke clipboard";
}