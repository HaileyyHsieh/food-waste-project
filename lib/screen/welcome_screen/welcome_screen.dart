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
          title: Image.asset(
            'images/food_waste_icon.png',
            height: 100,
            width: 100,
          ),
          toolbarHeight: 200,
          backgroundColor: kPrimaryColor,
          centerTitle: true,
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30.0),
              bottomRight: Radius.circular(30.0),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              Text(
                "Join as student, manager, or family",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 15),
              Card(
                elevation: 1.0,
                shadowColor: kDarkWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RadioListTile(
                    title: const Text('Student'),
                    subtitle: Text("Looking to provide feedback."),
                    autofocus: false,
                    activeColor: Colors.green,
                    selectedTileColor: Colors.white,
                    secondary: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/profile3.png'),
                        )
                      ),
                    ),
                    value: Character.student,
                    groupValue: _character,
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                        isStudent = true;
                        isFamily = false;
                        isManager = false;
                      });
                    },
                ),
              ),
              Card(
                elevation: 1.0,
                shadowColor: kDarkWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RadioListTile(
                    title: const Text('Family'),
                    subtitle: Text("Looking to acquire food."),
                    autofocus: false,
                    activeColor: Colors.green,
                    selectedTileColor: Colors.white,
                    value: Character.family,
                    groupValue: _character,
                    secondary: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/profile2.png'),
                          )
                      ),
                    ),
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
                elevation: 1.0,
                shadowColor: kDarkWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: RadioListTile(
                    title: const Text('Manager'),
                    subtitle: Text("Looking to manage food"),
                    value: Character.manager,
                    groupValue: _character,
                    autofocus: false,
                    activeColor: Colors.green,
                    selectedTileColor: Colors.white,
                    secondary: Container(
                      width: 45,
                      height: 45,
                      decoration: BoxDecoration(
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/profile1.png'),
                          )
                      ),
                    ),
                    onChanged: (Character? value) {
                      setState(() {
                        _character = value;
                        isManager = true;
                        isStudent = false;
                        isFamily = false;
                      });
                    },
                ),
              ),
              const SizedBox(height: 15.0),
              ButtonGlobalWithoutIcon(
                buttontext: 'Create a Account',
                buttonDecoration: kButtonDecoration.copyWith(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(30.0),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUp(),
                    ),
                  );
                },
                buttonTextColor: kNeutralColor,
              ),
              const SizedBox(height: 15.0),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LogIn(),
                        ),
                      );
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                      text: 'Already have an account? ',
                      style: kTextStyle.copyWith(color: kSubTitleColor),
                      children: [
                        TextSpan(
                          text: 'Log In',
                          style: kTextStyle.copyWith(
                              color: const Color(0xFF69B22A),
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
