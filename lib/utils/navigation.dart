import 'package:flutter/material.dart';
import 'package:flutter_localization/splash_screen.dart';

class Navigation {
  static splash(BuildContext context) {
    return Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const SplashScreen()),
      (route) => false,
    );
  }
}
