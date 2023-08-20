import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:nb_utils/nb_utils.dart';
import '../../../firebase/db.dart';
import '../../widgets/constant.dart';

class FamilyHomeScreen extends StatefulWidget {
  const FamilyHomeScreen({Key? key}) : super(key: key);

  @override
  State<FamilyHomeScreen> createState() => _FamilyHomeScreenState();
}

class _FamilyHomeScreenState extends State<FamilyHomeScreen> {
  Map<String, dynamic> foodMap = {};

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now); // formatted date
    // Create a `foodlog` variable and call the getFood function from db.dart (be sure to add await in front).
    // then call the setState function and if foodLog contains the formatted key, then set foodMap to
    // `foodLog[formatted]`.
    // ADD CODE HERE.....
    Map foodLog = await getFood();
    setState(() {
      if (foodLog.containsKey(formatted)) {
        foodMap = foodLog[formatted];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kDarkWhite,
      // Design app bar. It can just be a simple bar with an image in the center and the bgColor set.
      // ADD CODE HERE.....
      appBar: AppBar(
        title: Image.asset(
          'images/foodLogo.png',
          height: 100,
          width: 100,
        ),
        toolbarHeight: 70,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
        automaticallyImplyLeading: false,
        // shape: const RoundedRectangleBorder(
        //   borderRadius: BorderRadius.only(
        //     bottomLeft: Radius.circular(30.0),
        //     bottomRight: Radius.circular(30.0),
        // ),
        // ),
      ),

      body: Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Container(
          height: context.height(),
          padding: const EdgeInsets.only(
            left: 15.0,
            right: 15.0,
          ),
          width: context.width(),
          decoration: const BoxDecoration(
            color: kWhite,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30.0),
              topRight: Radius.circular(30.0),
            ),
          ),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Design a nice title for the page.
                // ADD CODE HERE......
                Text('Food Items'),
                ListView.builder(
                  itemCount: foodMap.length,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(bottom: 10.0),
                  itemBuilder: (_, index) {
                    String key = foodMap.keys.elementAt(index);
                    // Return a ListTile widget and design how each meal item will look. The ListTile widget
                    // should include the food name (key), the image (foodMap[key]['image']), and the quantity
                    // (foodMap[key]['quantity']).
                    // ADD CODE HERE.....
                    return ListTile(
                      title: foodMap[key],
                      leading: (foodMap[key]['image']),
                      trailing: (foodMap[key]['quantity']),
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
