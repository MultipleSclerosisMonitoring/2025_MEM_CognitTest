import 'l10n.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get app_title => 'My First Application';

  @override
  String get test_instructions => 'Match the symbol on the screen with its corresponding number using the keyboard on the bottom. Click on the button below to start the test.';

  @override
  String get start_test => 'Start Test';

  @override
  String get result_test => 'Go to Result';
}
