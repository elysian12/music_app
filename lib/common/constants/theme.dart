import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Color(0xff091227),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xff091227),
      ),
    ),
    primaryColor: Colors.white,
    secondaryHeaderColor: const Color(0xffA5C0FF),
  );
}

ThemeData darkTheme() {
  return ThemeData.dark().copyWith(
    scaffoldBackgroundColor: const Color(0xff091227),
    iconTheme: const IconThemeData(
      color: Color(0xffEAF0FF),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xff091227),
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xffEAF0FF),
      ),
    ),
    primaryColor: const Color(0xff091227),
    secondaryHeaderColor: const Color(0xffA5C0FF),
  );
}
