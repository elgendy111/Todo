import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xff5D9CEC);
  static const Color backgriundLight = Color(0xffDFECDB);
  static const Color backgriundDark = Color(0xff060E1E);
  static const Color green = Color(0xff61E757);
  static const Color red = Color(0xffEC4B4B);
  static const Color grey = Color(0xffC8C9CB);
  static const Color white = Color(0xffFFFFFF);

  static ThemeData lightTheme = ThemeData(
    primaryColor: primary,
    scaffoldBackgroundColor: backgriundLight,
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        backgroundColor: white,
        selectedItemColor: primary,
        unselectedItemColor: grey,
        showSelectedLabels: false,
        showUnselectedLabels: false),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: primary,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(color: white, width: 4),
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData();
}
