import 'package:flutter/material.dart';
import 'package:flutter_localization/constants/locale_constants.dart';
import 'package:flutter_localization/main.dart';
import 'package:flutter_localization/utils/navigation.dart';

import 'provider/locale_provider.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({Key? key}) : super(key: key);

  @override
  State<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  Locale? selectedLocale;

  @override
  void initState() {
    _getLocale();
    super.initState();
  }

  _getLocale() async {
    Locale locale = await getLocale();
    setState(() {
      selectedLocale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(translation(context).settingTitle),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: languageList.length,
        itemBuilder: (context, index) {
          Language language = languageList[index];
          return InkWell(
            onTap: () async {
              Locale _locale = await setLocale(language.languageCode);
              setState(() {
                selectedLocale = _locale;
              });
              MyApp.setLocale(context, _locale);
              Navigation.splash(context);
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 0.0,
                  horizontal: 8.0,
                ),
                leading: ClipRRect(
                  borderRadius: BorderRadius.circular(4.0),
                  child: Image.asset(
                    "assets/flags/${language.countryCode}.png",
                    width: 60,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                title: Text(language.name),
                trailing: Visibility(
                  visible:
                      selectedLocale?.languageCode == language.languageCode,
                  child: Icon(
                    Icons.check_circle_outline_rounded,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
