import 'package:flutter/material.dart';
import 'package:food_waste_proj_v1/screen/widgets/constant.dart';
import '../widgets/button_global.dart';
import 'login.dart';
import 'signup.dart';
import '../widgets/constant.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

enum Character { family, manager, student }

class _WelcomeScreenState extends State<WelcomeScreen> {
  Character? _character = Character.student;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Image.asset(
              'images/food_waste_icon.png',
              height: 100,
              width: 100,
          ),
          toolbarHeight: 150,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text(
              "Join as student, manager, or family",
              style: TextStyle(fontSize: 20),
            ),
            Card(
              child: RadioListTile(
                title: const Text('Student'),
                subtitle: Text("Students are the ones doing the surveys for the app"),
                value: Character.student,
                groupValue: _character,
                onChanged: (Character? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
            Card(
              child: RadioListTile(
                title: const Text('Family'),
                subtitle: Text("Family members are the ones seeing the various food options available"),
                value: Character.family,
                groupValue: _character,
                onChanged: (Character? value) {
                  setState(() {
                    _character = value;
                    isManager = false;
                    isStudent = false;
                    isFamily = true;
                  });
                },
              ),
            ),
            Card(
              child: RadioListTile(
                title: const Text('Manager'),
                subtitle: Text("People managing what kind of surveys that will be put up. "),
                value: Character.manager,
                groupValue: _character,
                onChanged: (Character? value) {
                  setState(() {
                    _character = value;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
