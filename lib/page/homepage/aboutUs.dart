import 'package:flutter/material.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Us"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: const EdgeInsets.only(
                  left: 20, right: 20, top: 10, bottom: 10),
              child: const Column(
                children: [
                  Text(
                    "Welcome to Spectra - Your Premier Travel Companion!",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Spectra is a dedicated tourism application designed to provide unforgettable travel experiences to adventurers like you. We believe that travel is one of the best ways to discover the wonders of the world, and Spectra is here to be your best friend on every journey.",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 8),
                  Text(
                    "What makes Spectra truly exceptional? We have a team of passionate experts in the field of tourism who work diligently to bring you a wealth of useful information and recommendations. With Spectra, you can explore the world's finest travel destinations with detailed guides, accurate reviews, and tailored recommendations that match your preferences.",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Key Features of Spectra:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '''-Comprehensive Travel Guides: Spectra offers comprehensive travel guides for each destination, including historical insights, cultural knowledge, major attractions, and local customs. With this, you can plan more informative and in-depth journeys.
-Customized Recommendations: Our app understands your preferences and provides personalized recommendations based on your interests, ranging from local cuisine to adventure activities.
-User Reviews: We empower the travel community to share their experiences through reviews and photos, so you can gain insights from people who have genuinely visited those places.
-Interactive Maps: Spectra comes with interactive maps that make navigation and trip management easier.
Latest News and Events: Stay updated with the latest travel news and special events in your chosen destinations.''',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Spectra is the answer to your questions about tourism destinations around the world. Together, let's explore the world with open eyes and open hearts. Happy adventuring with Spectra!",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
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