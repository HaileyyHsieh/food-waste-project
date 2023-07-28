import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';
import 'package:food_waste_proj_v1/screen/widgets/button_global.dart';
import '../../firebase/authentication.dart';
// import '../family_screen/family_home/family_home.dart';
// import '../manager_screen/manager_home/manager_home.dart';
// import '../student_screen/student_home.dart';
import '../widgets/constant.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool hidePassword = true;
  bool isCheck = true;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();

  void _navigateTo() {
    // if (isManager) {
    //   const ManagerHome().launch(context);
    // } else if (isFamily) {
    //   const FamilyHome().launch(context);
    // } else {
    //   const StudentScreen().launch(context);
    // }
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

  Map<String, dynamic> _getData() {
    Map<String, dynamic> data = {
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'phone': _phoneController.text,
      'address': 'N/A',
      'role': _getRole(),
      'email':_emailController.text
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                "Sign Up",
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(height: 15.0),
              TextFormField (
                controller: _firstNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'First Name',
                  hintText: 'Enter first name'
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField (
                controller: _lastNameController,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Last Name',
                  hintText: 'Enter last name'
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField (
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: 'Phone',
                  hintText: 'Enter phone number'
                ),
              ),
              const SizedBox(height: 10.0),
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
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Password',
                    hintText: 'Enter your password'
                ),
              ),
              const SizedBox(height: 10.0),
              TextFormField (
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password'
                ),
              ),
              const SizedBox(height: 10.0),
              // ElevatedButton(
              //   style: style,
              //   onPressed: null,
              //   child: const Text('Sign Up'),
              // ),
              ButtonGlobalWithoutIcon(
                buttontext: "Sign Up", 
                buttonDecoration: kButtonDecoration.copyWith(
                  color: kPrimaryColor,
                  borderRadius: BorderRadius.circular(10)
                ), 
                onPressed: () {
                  AuthenticationHelper().signUp(
                    email: _emailController.text,
                    password: _passwordController.text,
                  ).then(
                    (result) {
                      if (result == null) {
                        // _getData();
                        editUserInfo(_getData());
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
              )
            ]
          ),
        )
      ),
    );
  }
}
