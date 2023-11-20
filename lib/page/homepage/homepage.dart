// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:sensors/sensors.dart';
// IMPORT LIB FROM FUNCTION
import 'package:tubespariwisata/sharedPreferencesFunction/shared.dart';
import 'package:tubespariwisata/entity/user.dart';
import 'package:tubespariwisata/firebaseFunction/functionFirebaseHelper.dart';
// import 'package:tubespariwisata/anotherPageLauncher/launcher.dart';
// IMPORT FORCE PAGE
import 'package:tubespariwisata/page/homepage/myprofilecontainer.dart';
import 'package:tubespariwisata/page/homepage/mainhomecontainer.dart';
import 'package:tubespariwisata/page/homepage/griditemmaincontainer.dart';
import 'package:tubespariwisata/page/homepage/settingscontainer.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  var _selectedTab = _SelectedTab.home;
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;

  @override
  void initState() {
    fetchData();
    super.initState();

    accelerometerEvents.listen((event) {
      if (event.x.abs() > 20 || event.y.abs() > 20 || event.z.abs() > 20) {
        setState(() {
          isMenuVisible = !isMenuVisible;
        });
      }
    });
  }

  void fetchData() async {
    String? userID = await getUserID();
    if (userID != null) {
      setState(() {
        userId = userID;
      });

      searchUserByShared(userID).then((value) {
        setState(() {
          userTemp = value;
        });
      });
    }
  }

  Widget _getSelectedScreen() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return _buildHomeContainer();
      case _SelectedTab.person:
        return _buildPersonContainer();
      case _SelectedTab.search:
        return _buildSearchContainer();
      case _SelectedTab.settings:
        return _buildSettingsContainer();
    }
  }

  // HOME CONTAINER
  Widget _buildHomeContainer() {
    return const MainHome();
  }

  // PROFILE CONTAINER
  Widget _buildPersonContainer() {
    return const Profile();
  }

  // GRID ITEM CONTAINER
  Widget _buildSearchContainer() {
    return const MainGrid();
    // return MyHomePage();
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
    
    return Scaffold(
      extendBody: true,
      body: _getSelectedScreen(),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 1),
        child: DotNavigationBar(
          margin: const EdgeInsets.only(left: 10, right: 10),
          currentIndex: _SelectedTab.values.indexOf(_selectedTab),
          dotIndicatorColor: Colors.white,
          unselectedItemColor: Colors.grey[300],
          splashBorderRadius: 50,
          onTap: _handleIndexChanged,
          items: [
            DotNavigationBarItem(
              icon: const Icon(Icons.home),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.person),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.menu),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.settings),
              selectedColor: const Color(0xff73544C),
            ),
          ],
        ),
      ),
    );
  }
}

enum _SelectedTab { home, person, search, settings }