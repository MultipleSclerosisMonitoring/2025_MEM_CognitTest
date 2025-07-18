import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// This provider handles the multilenguage
///
/// Extends [ChangeNotifier] to notify the listeners when language [Locale] changes
class LocaleProvider extends ChangeNotifier {
  /// Current language in the app. It is English by default
  Locale _locale = const Locale('en');

  /// Getter that returns the current [Locale]
  Locale get locale => _locale;

  /// The builder loads the saved language when launching the app
  LocaleProvider() {
    _loadLocale(); // Load saved locale on startup
  }

  /// Loads the language saved in [SharedPreferences] if it exists, and updates [_locale] to that value.
  ///
  /// If any value is found, [notifyListeners] is called to update the depending widgets
  Future<void> _loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    String? languageCode = prefs.getString('language');
    if (languageCode != null) {
      _locale = Locale(languageCode);
      notifyListeners();
    }
  }

  /// Sets a new language and saves it in [SharedPreferences]
  ///
  /// It ensures that language is either `'en'` or `'es'` and after updating [_locale], [notifyListeners] is called to update depending widgets
  Future<void> setLocale(Locale locale) async {
    if (!['en', 'es'].contains(locale.languageCode)) return;
    _locale = locale;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', locale.languageCode);
  }
}
