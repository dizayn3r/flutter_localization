import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localization/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocaleProvider extends ChangeNotifier{
  Locale _locale = Locale('xx');
  Locale get locale => _locale;

  initLocale() async {
    log("In LocaleProvider | initLocale");
    SharedPreferences instance = await SharedPreferences.getInstance();
    bool status = instance.containsKey("locale");
    if(status){
      String languageCode = instance.getString("locale")!;
      _locale = Locale(languageCode);
    }
    log("Out LocaleProvider | initLocale | Locale: $_locale");
    return status;
  }

  void setLocale(Locale locale) async {
    log("In LocaleProvider | setLocale | Locale: $locale");
    SharedPreferences instance = await SharedPreferences.getInstance();
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    instance.setString("locale", locale.languageCode);
    log("Out LocaleProvider | setLocale | Locale: $locale");
    notifyListeners();
  }

  void resetLocale() {
    _locale = const Locale('en');
    notifyListeners();
  }
}