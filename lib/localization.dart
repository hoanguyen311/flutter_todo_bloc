import 'dart:async';
import 'package:flutter/material.dart';

class FlutterBlocLocalizations {
  static FlutterBlocLocalizations of(BuildContext context) {
    return Localizations.of<FlutterBlocLocalizations>(
      context,
        FlutterBlocLocalizations,
    );
  }

  String get appTitle => 'Flutter Todos';
}

class FlutterBlocLocalizationsDelegate extends LocalizationsDelegate<FlutterBlocLocalizations> {
  @override
  Future<FlutterBlocLocalizations> load(Locale locale) {
    return Future(() => FlutterBlocLocalizations());
  }

  @override
  bool shouldReload(LocalizationsDelegate<FlutterBlocLocalizations> old) {
    return false;
  }

  @override
  bool isSupported(Locale locale) {
    // TODO: implement isSupported
    return locale.languageCode.toLowerCase().contains('en');
  }
}