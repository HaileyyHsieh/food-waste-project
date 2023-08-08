import 'package:flutter/material.dart';
// import 'package:tracking_food_wasting/screen/welcome_screen/welcome_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../firebase/authentication.dart';
// import '../family_screen/family_home/family_home.dart';
import '../manager_screen/manager_home/manager_home.dart';
// import '../student_screen/student_home.dart';
import '../widgets/button_global.dart';
import '../widgets/constant.dart';
import '../welcome_screen/signup.dart';

import '../manager_screen/manager_home/manager_home_screen.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool hidePassword = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  void _navigateTo() {
    if (isManager)
      const ManagerHome().launch(context);
    // if (isManager)
      const ManagerHomeScreen().launch(context);

    // else if (isFamily)
    //   const FamilyHome().launch(context);
    // else
    //   const StudentScreen().launch(context);
  }

  String _getRole() {
    if (isManager) {
      return 'manager';
    }
    if (isFamily) {
      return 'family member';
    }
    return 'student';
  }

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
          toolbarHeight: 180,
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
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  const SizedBox(height: 10.0),
                  Text(
                    "Log In",
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    ),
                  ),
                  const SizedBox(height: 15.0),
                  TextFormField (
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Email',
                        hintText: 'Enter your email'
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextFormField (
                    textInputAction: TextInputAction.next,
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: true,
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        suffixIcon: IconButton(
                          icon: Icon(
                              hidePassword ? Icons.visibility_off : Icons.visibility
                          ),
                          onPressed: () {
                            setState(() {
                              hidePassword = !hidePassword;
                            });
                          },
                        )
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  ButtonGlobalWithoutIcon(
                    buttontext: "Log In",
                    buttonDecoration: kButtonDecoration.copyWith(
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.circular(10)
                    ),
                    onPressed: () {
                      AuthenticationHelper().signIn(
                        email: _emailController.text,
                        password: _passwordController.text,
                        role: _getRole(),
                      ).then(
                              (result) {
                            if (result == 'successful') {
                              _navigateTo();
                            }
                            else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(
                                  result,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ));
                            }
                          }
                      );
                    },
                    buttonTextColor: kNeutralColor,
                  ),
                  const SizedBox(height: 10.0),
                  Center(
                    child: GestureDetector(
                      onTap: () => const SignUp().launch(context),
                      child: RichText(
                        text: TextSpan(
                          text: 'Do not have an account? ',
                          style: kTextStyle.copyWith(color: kSubTitleColor),
                          children: [
                            TextSpan(
                              text: 'Sign Up',
                              style: kTextStyle.copyWith(
                                  color: const Color(0xFF69B22A),
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ]
              ),
            ),
          )
      ),
    );
  }
}
