import 'package:flutter/material.dart';
import 'package:food_waste_proj_v1/screen/widgets/constant.dart';
import '../widgets/button_global.dart';
import 'login.dart';
import 'signup.dart';

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
          title: Image.asset('images/food_waste_icon.png'),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("Join as student, manager, or family"),
            Card(
              child: RadioListTile(
                title: const Text('Student'),
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
                value: Character.family,
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
                title: const Text('Manager'),
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
