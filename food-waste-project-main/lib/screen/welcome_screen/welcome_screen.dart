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
          title: Text("AppBar"),
          backgroundColor: Colors.white,
          centerTitle: true,
        ),
        body: Column(
          children: [
            Text("title"),
            Card(
              child: RadioListTile(
              ),
            ),
          ],
        ),
      ),
    );
  }
}
