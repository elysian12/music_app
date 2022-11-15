import 'package:flutter/material.dart';

ThemeData lightTheme() {
  return ThemeData.light().copyWith(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: const IconThemeData(
      color: Color(0xff091227),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Colors.white),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(
        color: Color(0xff091227),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Color(0xff091227),
      ),
    ),
    indicatorColor: const Color(0xff091227),
    primaryColor: Colors.white,
    focusColor: const Color(0xff8996B8),
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
      titleTextStyle: TextStyle(
        color: Color(0xffEAF0FF),
        fontSize: 20,
        fontWeight: FontWeight.w600,
      ),
      iconTheme: IconThemeData(
        color: Color(0xffEAF0FF),
      ),
    ),
    drawerTheme: const DrawerThemeData(backgroundColor: Color(0xff091227)),
    indicatorColor: const Color(0xffEAF0FF),
    primaryColor: const Color(0xff091227),
    focusColor: const Color(0xffA5C0FF).withOpacity(0.5),
    secondaryHeaderColor: const Color(0xffA5C0FF),
  );
}
