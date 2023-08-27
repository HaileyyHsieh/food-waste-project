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

    if (!userInfo.containsKey('vote') || userInfo['vote'] != formatted) {
      Map<String, dynamic> data = {formatted: foodOptions};
      userVote(data);
      userInfo['vote'] = formatted;
      editUserInfo(userInfo).then(
              (value) => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              'Your vote was added',
              style: TextStyle(fontSize: 16),
            ),
          )));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
          'You already vote',
          style: const TextStyle(fontSize: 16),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        appBar: AppBar(
          title: Image.asset(
            'images/food_waste_icon.png',
            height: 100,
            width: 100,
          ),
          toolbarHeight: 130,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),

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
                   return Card(
                      child: RadioListTile(
                        title: Text(foodOptions[key]['item']),
                        secondary: Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFCCF2E3),
                            borderRadius: BorderRadius.circular(3.0),
                            image: DecorationImage(
                                image:
                                NetworkImage(foodOptions[key]['image']),
                                fit: BoxFit.cover),
                          ),
                        ),
                        autofocus: false,
                        activeColor: Colors.green,
                        selectedTileColor: Colors.white,
                        value: foodOptions[key]['item'],
                        groupValue: _food,
                        onChanged: (value) {
                          setState(() {
                            _food = foodOptions[key]['item'];
                            foodIndex = index;
                          });
                        }
                      )
                    );
                  }),
              const SizedBox(height: 15.0),
              ButtonGlobalWithoutIcon(
                buttontext: "Vote",
                buttonDecoration:  kButtonDecoration.copyWith(
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.circular(10)
                ),
                onPressed: vote,
                buttonTextColor: kWhite
              )
            ],
          ),
        ),
      ),
    );
  }
}
