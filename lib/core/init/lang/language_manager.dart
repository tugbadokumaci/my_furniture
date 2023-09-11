import 'package:flutter/material.dart';

class LanguageManager {
  static late LanguageManager _instance = LanguageManager._init();
  static LanguageManager get instance {
    return _instance;
  }

  LanguageManager._init();

  final enLocale = const Locale('en', 'US');
  final trLocale = const Locale('tr', 'TR');
  final deLocale = const Locale('de', 'DE');

  List<Locale> get supportedLocales => [enLocale, trLocale, deLocale];
}
