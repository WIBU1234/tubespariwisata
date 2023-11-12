import 'package:flutter/material.dart';

class CardDetailPage extends StatelessWidget {
  final String imagePath;
  final String cardText;

  CardDetailPage({required this.imagePath, required this.cardText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("resources/images/bali.jpg"), // Set your background image here
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
                  SizedBox(height: 20),
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    width: 300, // Adjust the width as needed
                    height: 200, // Adjust the height as needed
                  ),
                  SizedBox(height: 20),
                  Text(
                    cardText,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16), 
                    child: Text(
                      'Candi borobudur merupakan candi yang terletak di Magelang. Candi ini didirikan pada tahun 800M pada dinasti Syailendra',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                      textAlign: TextAlign.justify, 
                    ),
                  ),

                  SizedBox(height: 20),
                  Image.asset(
                    'resources/images/qrcode.png', // Replace with the barcode image path
                    width: 150,
                    height: 150, // Adjust the barcode image height as needed
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