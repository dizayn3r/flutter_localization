import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/homePage.dart';
import 'package:flutter_localization/language_selection_screen.dart';
import 'package:flutter_localization/provider/locale_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Locale? locale;

  @override
  void initState() {
    super.initState();
    getStatus();
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => locale?.languageCode == 'xx' ? const LanguageSelectionScreen() : const HomeScreen(),
        ),
      ),
    );
  }

  getStatus() async {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    bool status = await localeProvider.initLocale();
    if (status) {
      locale = localeProvider.locale;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: FlutterLogo(size: MediaQuery.of(context).size.height / 2),
      ),
    );
  }
}
