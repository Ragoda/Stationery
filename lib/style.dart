// ignore_for_file: deprecated_member_use, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:flutter/material.dart';

TextStyle textStyle = const TextStyle(
    color: Color(0XFF000000),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textStyleWhite = const TextStyle(
    color: Color(0XFFFFFFFF),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textBoldBlack = const TextStyle(
    color: Color(0XFF000000),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textBoldWhite = const TextStyle(
    color: Color(0XFFFFFFFF),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textBlackItalic = const TextStyle(
    color: Color(0XFF000000),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    fontFamily: "Cairo");

TextStyle textGrey = const TextStyle(
    color: Colors.grey,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textGreyBold = const TextStyle(
    color: Colors.grey,
    fontSize: 15.0,
    fontWeight: FontWeight.bold,
    fontFamily: "Cairo");

TextStyle textStyleBlue = const TextStyle(
    color: primaryColor,
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textStyleActive = const TextStyle(
    color: Color(0xFFF4AE36),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

TextStyle textStyleValidate = const TextStyle(
    color: Color(0xFFF44336),
    fontSize: 11.0,
    fontWeight: FontWeight.normal,
    fontStyle: FontStyle.italic,
    fontFamily: "Cairo");

TextTheme _buildTextTheme(TextTheme base) {
  return base.copyWith();
}

TextStyle textGreen = const TextStyle(
    color: Color(0xFF00c497),
    fontSize: 14.0,
    fontWeight: FontWeight.normal,
    fontFamily: "Cairo");

final ThemeData base = ThemeData.light();

ThemeData appTheme = ThemeData(
  fontFamily: "Cairo",
  primaryColor: primaryColor,
  // buttonColor: primaryColor,
  indicatorColor: whiteColor,
  splashColor: whiteColor,
  splashFactory: InkRipple.splashFactory,
  // accentColor: const Color(0xFF13B9FD),
  canvasColor: whiteColor,
  scaffoldBackgroundColor: whiteColor,
  backgroundColor: whiteColor,
  errorColor: const Color(0xFFFF0000),
  highlightColor: activeColor,
  iconTheme: const IconThemeData(color: primaryColor),
  buttonTheme: const ButtonThemeData(
    textTheme: ButtonTextTheme.primary,
  ),
  textTheme: _buildTextTheme(base.textTheme),
  primaryTextTheme: _buildTextTheme(base.primaryTextTheme),
  // accentTextTheme: _buildTextTheme(base.accentTextTheme),
);

Color textFieldColor = const Color.fromRGBO(168, 160, 149, 0.6);
const Color backgroundColor = Color(0xffeeeeee);
const Color whiteColor = Color(0XFFFFFFFF);
const Color blackColor = Color(0XFF242A37);
const Color greyColor = Color(0XFFF1F2F6);
const Color greyColor2 = Colors.grey;
const Color activeColor = Color(0xFFF44336);
const Color redColor = Color(0xFFFF0000);
const Color buttonStop = Color(0xFFF44336);
const Color primaryColor = Color.fromARGB(255, 216, 163, 2);
const Color facebook = Color(0xFF4267b2);
const Color googlePlus = Color(0xFFdb4437);
const Color yellow = Colors.pinkAccent;
const Color green1 = Colors.lightGreen;
const Color green2 = Colors.green;
const Color blue1 = Colors.lightBlue;
const Color blue2 = Colors.blue;
const Color tim = Colors.deepPurple;
const Color tim2 = Colors.deepPurpleAccent;
Color SecondaryColor = Colors.black;
//Colors.black;
// Colors.deepPurple.shade300;

const Color greenColor = Color(0xFF00c497);
//const Color greyColor = Colors.grey;

TextStyle textStyleSmall = const TextStyle(
    color: Color.fromRGBO(255, 255, 255, 0.8),
    fontSize: 12.0,
    fontFamily: "Cairo",
    fontWeight: FontWeight.normal);

//Image miniLogo =  Image(
//    image:  ExactAssetImage("assets/header-logo.png"),
//    height: 28.0,
//    width: 20.0,
//    alignment: FractionalOffset.center);

TextStyle headingWhite = const TextStyle(
  color: whiteColor,
  fontSize: 17.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle headingWhite18 = const TextStyle(
  color: whiteColor,
  fontSize: 18.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle headingRed = const TextStyle(
  color: redColor,
  fontSize: 22.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle headingGrey = const TextStyle(
  color: Colors.grey,
  fontSize: 22.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading18 = const TextStyle(
  color: whiteColor,
  fontSize: 18.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading18Black = const TextStyle(
  color: blackColor,
  fontSize: 18.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading20Black = const TextStyle(
  color: blackColor,
  fontSize: 20.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle headingBlack = const TextStyle(
  color: blackColor,
  fontFamily: "Cairo",
  fontWeight: FontWeight.bold,
);

TextStyle headingPrimaryColor = const TextStyle(
  color: primaryColor,
  fontSize: 22.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle headingLogo = const TextStyle(
  color: blackColor,
  fontSize: 22.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading35 = const TextStyle(
  color: whiteColor,
  fontSize: 25.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);
// TextStyle kTitleStyle = TextStyle(
//   color: Color(MyColors.header01),
//   fontWeight: FontWeight.bold,
// );

// TextStyle kFilterStyle = TextStyle(
//   color: Color(MyColors.bg02),
//   fontWeight: FontWeight.w500,
// );

TextStyle heading35Black = const TextStyle(
  color: blackColor,
  fontSize: 20.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading35Primary = const TextStyle(
  color: primaryColor,
  fontSize: 25.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

TextStyle heading35BlackNormal = const TextStyle(
  color: blackColor,
  fontSize: 25.0,
  fontFamily: "Cairo",
  fontWeight: FontWeight.normal,
);

const Color transparentColor = Color.fromRGBO(0, 0, 0, 0.2);
const Color activeButtonColor = Color.fromRGBO(43, 194, 137, 50.0);
const Color dangerButtonColor = Color(0XFFf53a4d);

int getColorHexFromStr(String colorStr) {
  colorStr = "FF$colorStr";
  colorStr = colorStr.replaceAll("#", "");
  int val = 0;
  int len = colorStr.length;
  for (int i = 0; i < len; i++) {
    int hexDigit = colorStr.codeUnitAt(i);
    if (hexDigit >= 48 && hexDigit <= 57) {
      val += (hexDigit - 48) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 65 && hexDigit <= 70) {
      // A..F
      val += (hexDigit - 55) * (1 << (4 * (len - 1 - i)));
    } else if (hexDigit >= 97 && hexDigit <= 102) {
      // a..f
      val += (hexDigit - 87) * (1 << (4 * (len - 1 - i)));
    } else {
      throw const FormatException("An error occurred when converting a color");
    }
  }
  return val;
}
