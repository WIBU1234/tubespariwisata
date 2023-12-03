// FLUTTER LIB IMPORTER
import 'package:flutter/material.dart';
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
// PAGE IMPORTER
import 'package:tubespariwisata/entity/user.dart';
// LAUNCHER FORCE PAGE
import 'package:tubespariwisata/adminLaunch/container/attractions.dart';
import 'package:tubespariwisata/page/homepage/settingscontainer.dart';

class AddMain extends StatefulWidget {
  const AddMain({Key? superKey}): super(key: superKey);
  

  @override
  State<AddMain> createState() => _AddMainState();
}

class _AddMainState extends State<AddMain> {
  var _selectedTab = _SelectedTab.home;
  bool isPasswordVisible = true;
  String? userId;
  User? userTemp;
  bool isMenuVisible = false;

  @override
  void initState() {
    super.initState();
  }

  Widget _getSelectedScreen() {
    switch (_selectedTab) {
      case _SelectedTab.home:
        return _buildAttractionsContainer();
      case _SelectedTab.person:
        return _buildPersonContainer();
      case _SelectedTab.search:
        return _buildSearchContainer();
      case _SelectedTab.settings:
        return _buildSettingsContainer();
    }
  }

  // HOME CONTAINER
  Widget _buildAttractionsContainer() {
    return const AttractionContainer();
    // return const SettingPage();
  }

  // PROFILE CONTAINER
  Widget _buildPersonContainer() {
   return const AttractionContainer();
    // return const SettingPage();
  }

  // GRID ITEM CONTAINER
  Widget _buildSearchContainer() {
   return const AttractionContainer();
    // return const SettingPage();
  }

  // SETTINGS CONTAINER
  Widget _buildSettingsContainer() {
    // return const AttractionContainer();
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
      key: const Key('adminPage'),
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
              icon: const Icon(Icons.add),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.list),
              selectedColor: const Color(0xff73544C),
            ),
            DotNavigationBarItem(
              icon: const Icon(Icons.search),
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