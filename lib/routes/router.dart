import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:music_app/models/album.dart';
import 'package:music_app/modules/auth/screens/login_screen.dart';
import 'package:music_app/modules/home/screens/album_tracks_screen.dart';
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
    final argumnets = settings.arguments;
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
      case AlbumTrackSceen.routeName:
        return MaterialPageRoute(
          builder: (_) => AlbumTrackSceen(
            album: (argumnets as Album),
          ),
        );
      default:
        return _errorRoute();
    }
  }
}
