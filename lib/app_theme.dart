import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff5D9CEC);
  static const Color backgriundLight = Color(0xffDFECDB);
  static const Color backgriundDark = Color(0xff060E1E);
  static const Color green = Color(0xff61E757);
  static const Color red = Color(0xffEC4B4B);
  static const Color grey = Color(0xffC8C9CB);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color darkGrayish = Color(0xff141922);

  static ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
      ),
      primaryColor: primary,
      scaffoldBackgroundColor: backgriundLight,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: white,
          selectedItemColor: primary,
          unselectedItemColor: grey,
          showSelectedLabels: false,
          showUnselectedLabels: false),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(color: white, width: 4),
        ),
      ),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: black),
          titleSmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: black)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ));

  static ThemeData darkTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Colors.transparent,
      ),
      primaryColor: primary,
      scaffoldBackgroundColor: backgriundDark,
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type: BottomNavigationBarType.fixed,
          backgroundColor: darkGrayish,
          selectedItemColor: primary,
          unselectedItemColor: grey,
          showSelectedLabels: false,
          showUnselectedLabels: false),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: primary,
        foregroundColor: white,
        shape: CircleBorder(
          side: BorderSide(color: white, width: 4),
        ),
      ),
      textTheme: const TextTheme(
          titleMedium: TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: black),
          titleSmall: TextStyle(
              fontSize: 16, fontWeight: FontWeight.w400, color: black)),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: primary),
      ));
}
