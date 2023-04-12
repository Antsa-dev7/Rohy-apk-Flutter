import 'dart:ui';

import 'package:flutter/material.dart';

const String title = "rohy";

// Colors
// const Color primaryColor = Color(0xff4801FF);
const Color primaryColor = Color(0xff4801FF);
const Color secondaryColor = Color(0xff5118F2);
const Color tertiaryColor = Color(0xffE43292);
const Color quaternaryColor = Color(0xff4E2BB4);
const Color quinaryColor = Color(0xff1D035F);
const Color senaryColor = Color(0xff737278);

List<Color> gradientColors = [
  tertiaryColor.withOpacity(1),
  secondaryColor.withOpacity(1),
  primaryColor.withOpacity(1),
];

// SplashScreen
const String backgroundImageUrl = "assets/rohy.png";

const TextStyle nindoStyle = TextStyle(
    fontSize: 12,
    color: Colors.white,
    fontWeight: FontWeight.bold,
    // letterSpacing: 2,
    fontStyle: FontStyle.italic
);

const TextStyle titleStyle = TextStyle(
  fontSize: 20,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: 2,
);

// headerText
const TextStyle postTitleStyle = TextStyle(
  fontSize: 15,
  color: quinaryColor,
  fontWeight: FontWeight.normal,
  letterSpacing: 1,
);

const TextStyle postContentStyle = TextStyle(
  fontSize: 15,
  color: Colors.black,
  fontWeight: FontWeight.normal,
  letterSpacing: 1,
);

const TextStyle postHeaderTitleStyle = TextStyle(
  fontSize: 16,
  color: primaryColor,
  fontWeight: FontWeight.normal,
  letterSpacing: 1,
);

const TextStyle headerTitleStyleWhite = TextStyle(
  fontSize: 16,
  color: Colors.white,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);

// headerText
const TextStyle headerTitleStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
  fontWeight: FontWeight.bold,
  letterSpacing: 1,
);



// tabTitleStyle
const TextStyle tabTitleStyle = TextStyle(
  fontSize: 16,
  color: Colors.black,
  letterSpacing: 0,
);

// bottomBarTabTitleStyle
const TextStyle bottomBarTabTitleStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
  letterSpacing: 0,
);

const formPadding = 10.0;

RegExp emailRegex = RegExp(r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$');

RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

RegExp zipValid = RegExp(r"^[a-z0-9][a-z0-9\- ]{0,10}[a-z0-9]$", caseSensitive: false);

// MG postal code validator
RegExp zVal = RegExp(r"^\d{3}$");

RegExp phoneRegex = RegExp(r'^(?:[+0][1-9])?[0-9]{10,12}$');