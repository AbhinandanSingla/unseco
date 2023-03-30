import 'package:flutter/cupertino.dart';

import '../local/locals.dart';

class LocaleProvider with ChangeNotifier {
  Locale? _locale;
  Locale? get locale => _locale;

  localeTitle(String val) {
    switch (val) {
      case 'en':
        return Text(
          'English',
          style: TextStyle(fontSize: 16.0),
        );
      case 'hi':
        return Text(
          'Hindi',
          style: TextStyle(fontSize: 16.0),
        );

      default:
        return Text(
          'English',
          style: TextStyle(fontSize: 16.0),
        );
    }}

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
  }
}
