import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:barcode_widget/barcode_widget.dart';

class CardDetailPage extends StatelessWidget {
  final String imagePath;
  final String cardText;
  final String uuid = const Uuid().v4();
  final String mapsLink = "https://maps.app.goo.gl/BRdnvTywiiLnbpEAA";

  CardDetailPage({required this.imagePath, required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                "resources/images/bali.jpg"), // Set your background image here
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 300, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                  const SizedBox(height: 20),
                  Text(
                    cardText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: const Text(
                      'Candi borobudur merupakan candi yang terletak di Magelang. Candi ini didirikan pada tahun 800M pada dinasti Syailendra',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      children: [
                        Text('ID: $uuid'),
                        const SizedBox(height: 20),
                        BarcodeWidget(
                          barcode: Barcode.qrCode(),
                          data: mapsLink,
                          width: 200,
                          height: 100,
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  )

                  // SizedBox(height: 20),
                  // Image.asset(
                  //   'resources/images/qrcode.png', // Replace with the barcode image path
                  //   width: 150,
                  //   height: 150, // Adjust the barcode image height as needed
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
