import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localization/homePage.dart';
import 'package:flutter_localization/provider/locale_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'provider/number_provider.dart';
import 'splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context)=> NumberProvider()),
        ChangeNotifierProvider(
          create: (context) => LocaleProvider(),
          builder: (context, child) {
            final localeProvider = Provider.of<LocaleProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: kReleaseMode,
              // App Locale
              locale: localeProvider.locale,
              // List all of the app's supported locales here
              supportedLocales: L10n.all,
              // These delegates make sure that the localization data for the proper language is loaded
              localizationsDelegates: const [
                // A class which loads the translations from JSON files
                AppLocalizations.delegate,
                // Built-in localization of basic text for Material widgets
                GlobalMaterialLocalizations.delegate,
                // Built-in localization of basic text for Cupertino widgets
                GlobalCupertinoLocalizations.delegate,
                // Built-in localization for text direction LTR/RTL
                GlobalWidgetsLocalizations.delegate,
              ],
              builder: EasyLoading.init(),
              home: const SplashScreen(),
            );
          },
        ),
      ],
    );
  }
}
