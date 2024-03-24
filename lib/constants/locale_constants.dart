const String langCode = "language_code";

const String english = "en";
const String hindi = "hi";
const String spanish = "es";

class Language {
  final int id;
  final String name;
  final String languageCode;
  final String countryCode;
  Language(this.id, this.name, this.languageCode, this.countryCode);
}

List<Language> languageList = <Language>[
  Language(1, "English", "en", "us"),
  Language(2, "Hindi", "hi", "in"),
];
