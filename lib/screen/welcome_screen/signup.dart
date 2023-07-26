// import 'package:flutter/material.dart';
// import 'package:nb_utils/nb_utils.dart';
// import 'package:tracking_food_wasting/firebase/db.dart';
// import 'package:tracking_food_wasting/screen/widgets/button_global.dart';
// import '../../firebase/authentication.dart';
// import '../family_screen/family_home/family_home.dart';
// import '../manager_screen/manager_home/manager_home.dart';
// import '../student_screen/student_home.dart';
// import '../widgets/constant.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({Key? key}) : super(key: key);
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   bool hidePassword = true;
//   bool isCheck = true;
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _phoneController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//
//   void _navigateTo() {
//     if (isManager) {
//       const ManagerHome().launch(context);
//     } else if (isFamily) {
//       const FamilyHome().launch(context);
//     } else {
//       const StudentScreen().launch(context);
//     }
//   }
//
//   String _getRole() {
//     if (isManager) {
//       return 'manager';
//     }
//     if (isFamily) {
//       return 'family member';
//     }
//     return 'student';
//   }
//
//   Map<String, dynamic> _getData() {
//     Map<String, dynamic> data = {
//       'firstName': _firstNameController.text,
//       'lastName': _lastNameController.text,
//       'phone': _phoneController.text,
//       'address': 'N/A',
//       'role': _getRole(),
//       'email':_emailController.text
//     };
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         body: Column(
//           children: [
//             TextField (
//               decoration: InputDecoration(
//               border: InputBorder.none,
//               labelText: 'First Name',
//               hintText: 'Enter first name'
//             ),
//             TextField (
//               decoration: InputDecoration(
//               border: InputBorder.none,
//               labelText: 'Last Name',
//               hintText: 'Enter last name'
//             ),
//             TextField (
//               decoration: InputDecoration(
//               border: InputBorder.none,
//               labelText: 'Phone',
//               hintText: 'Enter phone number'
//             ),
//             TextField (
//               decoration: InputDecoration(
//               border: InputBorder.none,
//               labelText: 'Email',
//               hintText: 'Enter your email'
//             ),
//             ElevatedButton(
//               style: style,
//               onPressed: null,
//               child: const Text('Sign Up'),
//             ),
//           ]
//         )
//       ),
//     );
//   }
// }
