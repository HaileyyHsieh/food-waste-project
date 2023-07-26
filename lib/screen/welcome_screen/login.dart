// import 'package:flutter/material.dart';
// import 'package:tracking_food_wasting/screen/welcome_screen/welcome_screen.dart';
// import 'package:nb_utils/nb_utils.dart';
//
// import '../../firebase/authentication.dart';
// import '../family_screen/family_home/family_home.dart';
// import '../manager_screen/manager_home/manager_home.dart';
// import '../student_screen/student_home.dart';
// import '../widgets/button_global.dart';
// import '../widgets/constant.dart';
//
// class LogIn extends StatefulWidget {
//   const LogIn({Key? key}) : super(key: key);
//
//   @override
//   State<LogIn> createState() => _LogInState();
// }
//
// class _LogInState extends State<LogIn> {
//   bool hidePassword = false;
//
//   TextEditingController _emailController = TextEditingController();
//   TextEditingController _passwordController = TextEditingController();
//
//   void _navigateTo() {
//     if (isManager)
//       const ManagerHome().launch(context);
//     else if (isFamily)
//       const FamilyHome().launch(context);
//     else
//       const StudentScreen().launch(context);
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//     );
//   }
// }
