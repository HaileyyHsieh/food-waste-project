import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:food_waste_proj_v1/screen/widgets/constant.dart';
// import '../family_profile/family_profile_details.dart';
import 'family_home_screen.dart';

class FamilyHome extends StatefulWidget {
  const FamilyHome({Key? key}) : super(key: key);

  @override
  State<FamilyHome> createState() => _FamilyHomeState();
}

class _FamilyHomeState extends State<FamilyHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    FamilyHomeScreen(),
    FamilyHomeScreen(),
    // FamilyProfileDetails(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: _widgetOptions.elementAt(_currentPage),
      // Design bottomNavigationBar property with BottomNavigationBar widget: home, profile
      // ADD CODE HERE.....
        bottomNavigationBar: BottomNavigationBar(
          onTap: (int index) {
            setState(() {
              _currentPage = index;
            });
          },
          currentIndex: _currentPage,
          backgroundColor: kWhite,
          selectedItemColor: kPrimaryColor,
          unselectedItemColor: kLightGrayColor,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_rounded),
              label: 'Profile',
            ),
          ],
        )
    );
  }
}
