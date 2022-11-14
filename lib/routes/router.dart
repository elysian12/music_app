import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_app/modules/auth/screens/login_screen.dart';
import 'package:music_app/modules/home/screens/home_screen.dart';

class MyRouter {
  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return const Scaffold(
        body: Center(
          child: Text('Route Not Defined'),
        ),
      );
    });
  }

  static Route<dynamic>? generateRoute(RouteSettings settings) {
    log('Route : ${settings.name}');
    switch (settings.name) {
      case '/':
        return null;
      case LoginScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const LoginScreen(),
        );
      case HomeScreen.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
        );
      default:
        return _errorRoute();
    }
  }
}
