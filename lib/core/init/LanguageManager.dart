import 'package:flutter/material.dart';

class LanguageManager {
  static LanguageManager? _instance;
  static LanguageManager get instance {
    _instance ??= LanguageManager._init();
    return _instance!;
  }

  LanguageManager._init();

  final enLocale = Locale('en', 'US');
  final trLocale = Locale('tr');
  final frLocale= Locale('fr');

  List<Locale> get supportedLocales => [enLocale, trLocale,frLocale];

  var languages={
    'en-US':'English',
    'fr':'Français',
    'tr':'Türkçe',
  };
}