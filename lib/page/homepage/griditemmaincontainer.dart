// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
// IMPORT FORCE PAGE
import 'package:tubespariwisata/page/homepage/card_detail_page.dart';
import 'package:tubespariwisata/page/homepage/settingscontainer.dart';
import 'package:tubespariwisata/firebaseFunction/apiHelper/apiUserFunction.dart';

class MainGrid extends StatefulWidget {
  const MainGrid({Key? key}) : super(key: key);

  @override
  State<MainGrid> createState() => _MainGridState();
}

class _MainGridState extends State<MainGrid> {
  var _selectedTab = _SelectedTab.attractions;
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      ApiFunctionHelper.searchUserByShared(userID).then((value) {
        setState(() {
          userTemp = value;
        });
      });
    }
  }

  Widget _getSelectedScreen() {
    switch (_selectedTab) {
      case _SelectedTab.attractions:
        return _buildHomeContainer();
      case _SelectedTab.tours:
        return _buildPersonContainer();
      case _SelectedTab.culture:
        return _buildSearchContainer();
      case _SelectedTab.culinary:
        return _buildSettingsContainer();
    }
  }

  // HOME CONTAINER
  Widget _buildHomeContainer() {
    return const SettingPage();
  }

  // PROFILE CONTAINER
  Widget _buildPersonContainer() {
    return const SettingPage();
  }

  // GRID ITEM CONTAINER
  Widget _buildSearchContainer() {
    return const SettingPage();
  }

  // SETTINGS CONTAINER
  Widget _buildSettingsContainer() {
    return const SettingPage();
  }

  void _handleIndexChanged(int i) {
    setState(() {
      _selectedTab = _SelectedTab.values[i];
    });
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailPage(
                          imagePath: "resources/images/aceh.jpg",
                          cardText: "Masjid Baihturrahman - Aceh",
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4,
                    child: Column(
                      children: [
                        ClipRect(
                          child: SizedBox(
                            width: 300, // Fixed image width
                            height: 90, // Fixed image height
                            child: Image.asset(
                              "resources/images/aceh.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Masjid Baihturrahman - Aceh",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailPage(
                          imagePath: "resources/images/yogyakarta.webp",
                          cardText: "Candi Borobudur - Magelang",
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4, // Customize card elevation as needed
                    child: Column(
                      children: [
                        ClipRect(
                          child: SizedBox(
                            width: 300, // Fixed image width
                            height: 90, // Fixed image height
                            child: Image.asset(
                              "resources/images/yogyakarta.webp",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Candi Borobudur - Magelang",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    // Navigate to the card detail page for Card 1
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CardDetailPage(
                          imagePath: "resources/images/kulonProgo.jpeg",
                          cardText: "Embung Tirta - Kulonprogo",
                        ),
                      ),
                    );
                  },
                  child: Card(
                    elevation: 4, // Customize card elevation as needed
                    child: Column(
                      children: [
                        ClipRect(
                          child: SizedBox(
                            width: 300, // Fixed image width
                            height: 90, // Fixed image height
                            child: Image.asset(
                              "resources/images/kulonProgo.jpeg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Embung Tirta - Kulonprogo",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _SelectedTab { attractions, tours, culture, culinary }