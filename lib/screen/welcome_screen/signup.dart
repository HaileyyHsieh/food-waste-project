import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:food_waste_proj_v1/firebase/db.dart';
import 'package:food_waste_proj_v1/screen/widgets/button_global.dart';
import '../../firebase/authentication.dart';
// import '../family_screen/family_home/family_home.dart';
// import '../manager_screen/manager_home/manager_home.dart';
// import '../student_screen/student_home.dart';
import '../widgets/constant.dart';
import '../welcome_screen/login.dart';

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
        appBar: AppBar(
          title: Image.asset(
            'images/food_waste_icon.png',
            height: 100,
            width: 100,
          ),
          toolbarHeight: 180,
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
          padding: const EdgeInsets.all(12.0),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Checkbox(
                        activeColor: kPrimaryColor,
                        visualDensity: const VisualDensity(horizontal: -4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2.0),
                        ),
                        value: isCheck,
                        onChanged: (value) {
                          setState(() {
                            isCheck = !isCheck;
                          });
                        }),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          text: 'Yes, I understand and agree to the ',
                          style: kTextStyle.copyWith(color: kSubTitleColor),
                          children: [
                            TextSpan(
                              text: 'Terms of Service.',
                              style: kTextStyle.copyWith(
                                  color: kPrimaryColor,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => const LogIn().launch(context),
                    child: RichText(
                      text: TextSpan(
                        text: 'Already have an account? ',
                        style: kTextStyle.copyWith(color: kSubTitleColor),
                        children: [
                          TextSpan(
                            text: 'Log In',
                            style: kTextStyle.copyWith(
                                color: const Color(0xFF69B22A),
                                fontWeight: FontWeight.w500),
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
