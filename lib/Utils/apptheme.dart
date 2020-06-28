import 'dart:ui';

import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color notWhite = Color(0xFFEDF0F2);
  static const Color nearlyWhite = Color(0xFFFEFEFE);
  static const Color white = Color(0xFFFFFFFF);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);
  static const Color light_blue = Color(0xFF5DADE2);
  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color chipBackground = Color(0xFFEEF1F3);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color light_gray = Color(0xFFE8E8E8);
  static const String fontName = 'WorkSans';
  static const Color red_dark = Color(0xFF8B0000);

  static const TextStyle display1 = TextStyle(
    // h4 -> display1
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: darkerText,
  );

  static const TextStyle headline = TextStyle(
    // h5 -> headline
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: darkerText,
  );

  static const TextStyle title = TextStyle(
    // h6 -> title
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.18,
    color: darkerText,
  );

  static const TextStyle subtitle = TextStyle(
    // subtitle2 -> subtitle
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    letterSpacing: -0.04,
    color: darkText,
  );

  static const TextStyle body2 = TextStyle(
    // body1 -> body2
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: darkText,
  );

  static const TextStyle body1 = TextStyle(
    // body2 -> body1
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: darkText,
  );

  static Color lightPrimary = Colors.grey[200];
  static Color darkPrimary = Colors.black;
  static Color lightAccent = Colors.blue;
  static Color darkAccent = Colors.lightBlue;
  static Color lightBG = Color(0xfffcfcff);
  static Color darkBG = Colors.black;
  static Color badgeColor = Colors.red;

  static ThemeData lightTheme = ThemeData(

    primaryIconTheme: IconThemeData(
        color: Colors.black87
    ),
    iconTheme: IconThemeData(
        color: Colors.black87
    ),
    dividerColor: Colors.grey[200],
    buttonTheme: ButtonThemeData(
      hoverColor: Colors.grey,
      splashColor: Colors.grey,
      buttonColor: Colors
          .grey, //  <-- dark color//  <-- this auto selects the right color
    ),
    backgroundColor: lightBG,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.white,
      selectedItemColor: Colors.black87,
      unselectedItemColor: Colors.black45,
    ),
    primaryColor: lightPrimary,
    accentColor:  lightAccent,
    cursorColor: lightAccent,
   // scaffoldBackgroundColor: Colors.white,
    tabBarTheme: TabBarTheme(
      unselectedLabelColor: Colors.black54,
      labelColor: Colors.black87,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0.5,
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        title: TextStyle(
          color: darkBG,
          fontSize: 20.0,
          //fontWeight: FontWeight.w00,
        ),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    primaryIconTheme: IconThemeData(
      color: Colors.white
    ),
    cardColor: Colors.white10,
    dividerColor: Colors.grey[400],
    iconTheme: IconThemeData(
        color: Colors.white
    ),
    //fontFamily: 'Times',
    buttonTheme: ButtonThemeData(
      buttonColor: Colors
          .white, //  <-- dark color//  <-- this auto selects the right color
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.black45,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white54
    ),
    brightness: Brightness.dark,
    backgroundColor: Colors.black87,
    //primaryColor: darkPrimary,
    accentColor: darkAccent,
  //  scaffoldBackgroundColor: Colors.grey,
    cursorColor: darkAccent,
    appBarTheme: AppBarTheme(
      //elevation: 0.5,
      textTheme: TextTheme(
        // ignore: deprecated_member_use
        title: TextStyle(
          color: lightBG,
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
        ),
      ),
    ),
  );
}

