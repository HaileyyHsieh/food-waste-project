import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../welcome_screen/welcome_screen.dart';
import '../widgets/constant.dart';

class OnBoard extends StatefulWidget {
  const OnBoard({
    Key? key,
  }) : super(key: key);

  @override
  State<OnBoard> createState() => _OnBoardState();
}

class _OnBoardState extends State<OnBoard> {
  PageController pageController = PageController(initialPage: 0);
  int currentIndexPage = 0;
  double percent = 0.34;

  List<Map<String, dynamic>> sliderList = [
    {"title": "school manager",
      "description": "Keep track of food that is not sold every day in school restaurant, as a standard for purchasing",
      "icon": "images/school-manager.png",
    },
    {"title": "student",
      "description": "Fill in the menu survey every week to know your preference as the standard for prepare food",
      "icon": "images/student.png",
    },
    {"title": "family",
      "description": "Inquire, register and request the food that is not sold on the day",
      "icon": "images/family.png",
    },
  ];

  @override
  void setState(fn) {
    if (mounted) super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kWhite,
        body: PageView.builder(
          itemCount: sliderList.length,
          physics: const PageScrollPhysics(),
          controller: pageController,
          onPageChanged: (int index) =>
              setState(() => currentIndexPage = index),
          itemBuilder: (_, i) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 300,
                    width: context.width(),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            sliderList[i]['icon'],
                          ),
                          fit: BoxFit.contain),
                    ),
                  ),
                ),
                Container(
                  width: context.width(),
                  decoration: const BoxDecoration(color: kWhite, boxShadow: [
                    BoxShadow(
                        color: kDarkWhite,
                        spreadRadius: 4.0,
                        blurRadius: 10.0,
                        offset: Offset(0, -20))
                  ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SizedBox(height: 25.0),
                      Text(
                        sliderList[i]['title'].toString(),
                        textAlign: TextAlign.center,
                        style: kTextStyle.copyWith(
                            color: kNeutralColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0),
                      ),
                      const SizedBox(height: 10.0),
                      Padding(
                        padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                        child: Text(
                          sliderList[i]['description'].toString(),
                          style: kTextStyle.copyWith(
                            color: kSubTitleColor,
                          ),
                          maxLines: 3,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 60.0),
                      GestureDetector(
                        onTap: () {
                          setState(
                            () {
                              currentIndexPage < 2;
                              currentIndexPage < 2
                                  ? pageController.nextPage(
                                      duration:
                                          const Duration(microseconds: 3000),
                                      curve: Curves.bounceInOut)
                                  :
                              Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WelcomeScreen(),
                                      ),
                                    );
                            },
                          );
                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('images/arrow.png'), // clickable image, go on to the next page
                            ),
                          ),
                        ),
                      ),
                      SmoothPageIndicator(
                        controller: pageController,
                        count: 3,
                        effect: JumpingDotEffect(
                          dotHeight: 6.0,
                          dotWidth: 6.0,
                          jumpScale: .7,
                          verticalOffset: 15,
                          activeDotColor: kPrimaryColor,
                          dotColor: kPrimaryColor.withOpacity(0.2),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
