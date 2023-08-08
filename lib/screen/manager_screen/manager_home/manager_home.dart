import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
// import 'package:tracking_food_wasting/screen/manager_screen/add_items/voteFood.dart';
// import 'package:tracking_food_wasting/screen/manager_screen/manager_home/manager_home_screen.dart';
// import 'package:tracking_food_wasting/screen/widgets/constant.dart';
// import '../add_items/donate_food.dart';
import '../profile/manager_profile.dart';
import '../../widgets/constant.dart';

class ManagerHome extends StatefulWidget {
  const ManagerHome({Key? key}) : super(key: key);

  @override
  State<ManagerHome> createState() => _ManagerHomeState();
}

class _ManagerHomeState extends State<ManagerHome> {
  int _currentPage = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    // ManagerHomeScreen(),
    // VoteFood(),
    // DonateFood(),
    ManagerProfile(),
    ManagerProfile(),
    ManagerProfile(),
    ManagerProfile(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhite,
      body: _widgetOptions.elementAt(_currentPage),
      // Design bottomNavigationBar property with BottomNavigationBar widget: home, vote, food, profile
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
            icon: Icon(Icons.how_to_vote_rounded),
            label: 'Vote',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.fastfood_rounded),
            label: 'Food',
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
