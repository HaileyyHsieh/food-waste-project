import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:food_waste_proj_v1/screen/widgets/constant.dart';
import '../../firebase/db.dart';
import '../widgets/button_global.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({Key? key}) : super(key: key);

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  Map<String, dynamic> foodOptions = {};
  String? _food;
  int foodIndex = 0;

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now);
    Map voteLog = await getVote();
    setState(() {
      if (voteLog.containsKey(formatted)) {
        foodOptions = voteLog[formatted]; // gets map of food items with info
        _food = foodOptions.keys.elementAt(0); // gets the first food item
        print(_food);
      }
    });
  }

  vote() async {
    Map<String, dynamic> userInfo = await getUserInfo(); // gets user's info from Firebase
    foodOptions[_food!]['numberVote'] += 1; // adds a vote to the food item

    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final String formatted = formatter.format(now); // formatted date for today

    // Check if userInfo doesn't contain the key 'vote' or userInfo['vote'] is not is equal to today's date, then call the
    // userVote function from db.dart and pass in `{formatted: foodOptions}` and set userInfo['vote'] to today's date. Call the
    // editUserInfo function from db.dart, add a .then function that uses the SnackBar widget to tell the user that their vote
    // was added. Else show a SnackBar message that tells the user that they already voted. An example of how to show a Snack Bar is
    // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
    //         content: Text(
    //           'You already vote',
    //           style: const TextStyle(fontSize: 16),
    //         ),
    //       ));
    // ADD CODE HERE.......
    if (userInfo.containsKey('vote') || userInfo['vote'] != now) {
      userVote({formatted: foodOptions});
      userInfo['vote'] = formatted;
      editUserInfo().then(

      )
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        // Design appbar: can use app bar from welcome_screen.dart and modify it (e.g. change height, bg color, etc)
        // ADD CODE HERE......

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            children: [
              Center(
                child: Text(
                  'Vote for today food',
                  style: kTextStyle.copyWith(
                      color: kNeutralColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0),
                ),
              ),
              const SizedBox(height: 20.0),
              ListView.builder(
                  physics: ScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: foodOptions.length,
                  itemBuilder: (BuildContext context, int index) {
                    String key = foodOptions.keys.elementAt(index);
                    // Design how each vote item will look. Return a Card widget with a RadioListTile widget as the child.
                    // Each radio list tile will have a title to display the food item ( foodOptions[key]['item'] ) and
                    // a secondary property with the food image set ( foodOptions[key]['image'] ). The value property will
                    // be set to `foodOptions[key]['item']`, set group_value to `_food`, and for the onChanged property,
                    // call the setState() function and add `_food = foodOptions[key]['item'];` and `foodIndex = index;`.
                    // ADD CODE HERE.....

                  }),

              // Add a vote button using the ButtonGlobalWithoutIcon widget and call the vote function on pressed.
              // ADD CODE HERE......

            ],
          ),
        ),
      ),
    );
  }
}
