import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:convert';

final tr = AppLocalizations.instance!.getTranslate;

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en')
  ];

  // This [delegate] will be called from MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static AppLocalizations? get instance => _AppLocalizationsDelegate.instance;

  Map<String, String>? _localizedString;

  // This method will load the required JSON file according to locale
  Future<bool> load() async {
    String jsonStr =
        await rootBundle.loadString("locale/${locale.languageCode}.json");
    Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    _localizedString =
        jsonMap.map((key, value) => MapEntry(key, value.toString()));

    return true;
  }

  // This method will return the localized string for given key
  String translate(String key) {
    return _localizedString![key] ?? key;
  }
  String getTranslate(String key) {
    return AppLocalizations.instance!.translate(key).isEmpty
        ? key
        : AppLocalizations.instance!.translate(key);
  }
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    // All supported languages
    return ["en", "ar"].contains(locale.languageCode);
  }

  static AppLocalizations? instance;

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations appLocalizations = AppLocalizations(locale);

    // The [load] method from AppLocalizations class runs here
    await appLocalizations.load();
    instance = appLocalizations;

    return appLocalizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) {
    return false;
  }
}
