// IMPORT LIB FROM FLUTTER
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:intl/intl.dart';

// IMPORT LIB FROM ENTITY
import 'package:tubespariwisata/entity/user.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key, required this.user}) : super(key: key);

  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Homepage> {
  var _selectedTab = _SelectedTab.home;

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
            // Add your content here
            child: const Text('Home Screen'),
          ),
        ),
      ),
    );
  }

  // PROFILE CONTAINER
  Widget _buildPersonContainer() {
  TextEditingController controllerTanggalLahir = TextEditingController();

  Future<void> selectDate() async {
    DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1900),
        lastDate: DateTime(3000));
    if (picked != null) {
      setState(() {
        controllerTanggalLahir.text =
            DateFormat('yyyy-MM-dd').format(picked).toString().split(" ")[0];
      });
    }
  }

    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 50), // Adjust the top value as needed
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
            child: Container(
              child: Padding(
                padding: const EdgeInsets.all(3.0),
                child: Center(
                  child: Container(
                    width: 300,
                    height: 580,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.black,
                        width: 1,
                      ),
                    ),

                    // Add your content here SINI WOI
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        const Text(
                          "My Profile",
                          style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Align(
                            alignment: Alignment.topCenter,
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage:
                                  AssetImage("resources/images/bali.jpg"),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.only(right: 30, left: 30),
                          child: Container(
                            decoration: const BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                            height: 270,
                            width: 260,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  // ADD CONTENT FOR INPUT
                                ],
                              ),
                            )
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // GRID ITEM CONTAINER
  Widget _buildSearchContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 50), // Adjust the top value as needed
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
            child: const Text('Grid Screen'),
          ),
        ),
      ),
    );
  }

  // SETTINGS CONTAINER
  Widget _buildSettingsContainer() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("resources/images/bali.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding:
            const EdgeInsets.only(bottom: 50), // Adjust the top value as needed
        child: Center(
          child: Container(
            width: 330,
            height: 610,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white.withOpacity(0.8),
            ),
            // Add your content here
            child: const Text('Settings Screen'),
          ),
        ),
      ),
    );
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
