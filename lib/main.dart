import 'package:flutter/material.dart';
import 'package:food_waste_proj_v1/screen/splashscreen/mt_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Freelancer App',
      theme: ThemeData(fontFamily: 'Display'),
      home: const SplashScreen(),
    );
  }
}
