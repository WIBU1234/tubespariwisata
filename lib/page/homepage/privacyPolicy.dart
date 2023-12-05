import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  const PrivacyPolicy({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Privacy Policy"),
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
                    "At Spectra, we are committed to protecting your privacy and ensuring the security of your personal information. This Privacy Policy outlines how we collect, use, disclose, and safeguard your data when you use our tourism application.",
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Information We Collect:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '''
Personal Information: When you create an account or use our services, we may collect personal information such as your name, email address, and contact details.
Travel Preferences: We collect data on your travel preferences, interests, and activities to provide you with tailored recommendations.
Location Information: We may collect location data to offer location-based services and improve your experience.
User Content: Any reviews, photos, or comments you share on Spectra may be stored as user-generated content.
                    ''',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "How We Use Your Information:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '''
Enhancing Your Experience: We use your data to provide a personalized experience, including customized recommendations and content.
Communication: We may use your contact details to send you updates, newsletters, and important information regarding Spectra.
Improving Our Services: Data is used for analytics to enhance our services, content, and user interface.
Information Sharing:
User Reviews: Your reviews and photos may be visible to other users, contributing to our travel community.
Third-Party Partners: We may share information with trusted third-party partners to improve your experience and offer you special promotions.
                    ''',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Data Security:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '''
We employ security measures to protect your data from unauthorized access, disclosure, or alteration. However, no method of data transmission over the internet is entirely secure, and we cannot guarantee absolute security.
                    ''',
                    style: TextStyle(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Your Choices:",
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    '''
You have the right to access, modify, or delete your personal information at any time. You can also opt-out of promotional emails.
                    ''',
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
