import 'package:flutter/material.dart';
import 'package:food_waste_proj_v1/screen/widgets/constant.dart';

import 'onboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    await Future.delayed(const Duration(seconds: 2)).then((value) =>
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => const OnBoard())));
  }

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kLightNeutralColor,
        body: Stack(
          alignment: Alignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Container(
                      height: 180,
                      width: 180,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('images/food_waste_icon.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Column(
                      children: [
                        Text("Version 1.1"),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   height: 630,
            //   decoration: const BoxDecoration(
            //     image: DecorationImage(
            //       image: AssetImage('images/white.jpg'),
            //     ),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
