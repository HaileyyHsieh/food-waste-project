import 'package:flutter/material.dart';

import 'constant.dart';

class SocialIcon extends StatelessWidget {
  const SocialIcon({
    Key? key,
    required this.bgColor,
    required this.iconColor,
    required this.icon,
    required this.borderColor,
  }) : super(key: key);
  final IconData icon;
  final Color bgColor;
  final Color iconColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: borderColor),
        color: bgColor,
      ),
      child: Icon(
        icon,
        color: iconColor,
      ),
    );
  }
}

// ignore: must_be_immutable
class Button extends StatelessWidget {
  Button({Key? key, required this.containerBg, required this.borderColor, required this.buttonText, required this.textColor, required this.onPressed}) : super(key: key);

  final Color containerBg;
  final Color borderColor;
  final String buttonText;
  final Color textColor;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        height: 40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: containerBg,
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(color: borderColor),
        ),
        child: Center(
          child: Text(
            buttonText,
            style: kTextStyle.copyWith(color: textColor),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

