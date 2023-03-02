import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localization/l10n/l10n.dart';
import 'package:flutter_localization/provider/locale_provider.dart';
import 'package:flutter_localization/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() => _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Locale? selectedLocale;

  @override
  void initState() {
    selectedLocale = Provider.of<LocaleProvider>(context, listen: false).locale;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context, listen: false);
    languageName(Locale locale) {
      switch (locale.languageCode) {
        case 'en':
          return "English";
        case 'hi':
          return "Hindi";
        case 'ar':
          return "Arabic";
        default:
          return null;
      }
    }

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: kToolbarHeight),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.settingTitle,
                  style: TextStyle(
                    fontSize: 60.0,
                    color: Colors.grey.shade900,
                  ),
                ),
                const SizedBox(height: kToolbarHeight / 2),
                Text(
                  AppLocalizations.of(context)!.settingSubtitle,
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.grey.shade900,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(16.0),
              color: Colors.grey.shade50,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.0,
                crossAxisSpacing: 16.0,
                childAspectRatio: 1.5,
                children: List.generate(
                  L10n.all.length,
                  (index) {
                    Locale locale = L10n.all[index];
                    return GestureDetector(
                      onTap: () {
                        EasyLoading.show();
                        setState(() {
                          selectedLocale = locale;
                        });
                        localeProvider.setLocale(locale);
                        Future.delayed(const Duration(seconds: 2), () {
                          EasyLoading.dismiss();
                          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const SplashScreen()), (route) => false);
                        });
                      },
                      child: Card(
                        elevation: 3.0,
                        color: locale == selectedLocale ? Theme.of(context).colorScheme.primary : Theme.of(context).colorScheme.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.0),
                        ),
                        child: Center(
                          child: Text(
                            languageName(locale)!,
                            style: TextStyle(
                              fontSize: 24.0,
                              color: locale == selectedLocale ? Theme.of(context).colorScheme.onPrimary : Theme.of(context).colorScheme.onSurface,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
