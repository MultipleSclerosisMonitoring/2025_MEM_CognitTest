import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'l10n_en.dart';
import 'l10n_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/l10n.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @app_title.
  ///
  /// In en, this message translates to:
  /// **'My First Application'**
  String get app_title;

  /// No description provided for @test_instructions.
  ///
  /// In en, this message translates to:
  /// **'Match the symbol on the screen with its corresponding number using the keyboard on the bottom. Click on the button below to start the test.'**
  String get test_instructions;

  /// No description provided for @start_test.
  ///
  /// In en, this message translates to:
  /// **'Start Test'**
  String get start_test;

  /// No description provided for @result_test.
  ///
  /// In en, this message translates to:
  /// **'Go to Result'**
  String get result_test;

  /// No description provided for @code_message.
  ///
  /// In en, this message translates to:
  /// **'Reference'**
  String get code_message;

  /// No description provided for @birth_message.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get birth_message;

  /// No description provided for @sex_message.
  ///
  /// In en, this message translates to:
  /// **'Sex'**
  String get sex_message;

  /// No description provided for @education_message.
  ///
  /// In en, this message translates to:
  /// **'Level of studies'**
  String get education_message;

  /// No description provided for @hand_message.
  ///
  /// In en, this message translates to:
  /// **'Hand you will do the test with'**
  String get hand_message;

  /// No description provided for @numberOfSymbols_message.
  ///
  /// In en, this message translates to:
  /// **'Number of symbols'**
  String get numberOfSymbols_message;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @primary.
  ///
  /// In en, this message translates to:
  /// **'Primary education'**
  String get primary;

  /// No description provided for @secondary.
  ///
  /// In en, this message translates to:
  /// **'Secondary education'**
  String get secondary;

  /// No description provided for @degree.
  ///
  /// In en, this message translates to:
  /// **'University degree'**
  String get degree;

  /// No description provided for @master.
  ///
  /// In en, this message translates to:
  /// **'Master\'s degree'**
  String get master;

  /// No description provided for @phd.
  ///
  /// In en, this message translates to:
  /// **'PhD'**
  String get phd;

  /// No description provided for @left.
  ///
  /// In en, this message translates to:
  /// **'Left'**
  String get left;

  /// No description provided for @right.
  ///
  /// In en, this message translates to:
  /// **'Right'**
  String get right;

  /// No description provided for @hand.
  ///
  /// In en, this message translates to:
  /// **'Hand'**
  String get hand;

  /// No description provided for @value_select.
  ///
  /// In en, this message translates to:
  /// **'Select'**
  String get value_select;

  /// No description provided for @cognition_test.
  ///
  /// In en, this message translates to:
  /// **'Cognition test'**
  String get cognition_test;

  /// No description provided for @data_error.
  ///
  /// In en, this message translates to:
  /// **'Please, fill up all of the fields correctly'**
  String get data_error;

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname'**
  String get nickname;

  /// No description provided for @enter_nickname.
  ///
  /// In en, this message translates to:
  /// **'Write your alias'**
  String get enter_nickname;

  /// No description provided for @user.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get user;

  /// No description provided for @profile_creation.
  ///
  /// In en, this message translates to:
  /// **'Create a new profile'**
  String get profile_creation;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get or;

  /// No description provided for @save_profile.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get save_profile;

  /// No description provided for @welcome_message.
  ///
  /// In en, this message translates to:
  /// **'Welcome! To start the test, please select a user or create a new profile.'**
  String get welcome_message;

  /// No description provided for @continue_.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continue_;

  /// No description provided for @wrong_code.
  ///
  /// In en, this message translates to:
  /// **'The reference code is incorrect'**
  String get wrong_code;

  /// No description provided for @test_finished.
  ///
  /// In en, this message translates to:
  /// **'Congratulations! You have successfully completed the test and your results have been correctly sent'**
  String get test_finished;

  /// No description provided for @test_finished_wrong.
  ///
  /// In en, this message translates to:
  /// **'Sorry! There has been an error sending your results. Please check your connection and retake the test'**
  String get test_finished_wrong;

  /// No description provided for @back_home.
  ///
  /// In en, this message translates to:
  /// **'Back to home page'**
  String get back_home;

  /// No description provided for @error_title.
  ///
  /// In en, this message translates to:
  /// **'INVALID REFERENCE CODE'**
  String get error_title;

  /// No description provided for @error_text.
  ///
  /// In en, this message translates to:
  /// **'Please try again or get in contact with your doctor'**
  String get error_text;

  /// No description provided for @view_profile.
  ///
  /// In en, this message translates to:
  /// **'View my profile'**
  String get view_profile;

  /// No description provided for @view_tests.
  ///
  /// In en, this message translates to:
  /// **'View my tests'**
  String get view_tests;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start test'**
  String get start;

  /// No description provided for @trial_warning.
  ///
  /// In en, this message translates to:
  /// **'You are about to start a 20-second practice test. It won\'t be registered, it\'s just to help you get familiar with the dynamics of the test.'**
  String get trial_warning;

  /// No description provided for @trial_title.
  ///
  /// In en, this message translates to:
  /// **'Trial test'**
  String get trial_title;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @start_trial.
  ///
  /// In en, this message translates to:
  /// **'Start trial'**
  String get start_trial;

  /// No description provided for @delete_profile.
  ///
  /// In en, this message translates to:
  /// **'Delete profile'**
  String get delete_profile;

  /// No description provided for @delete_message.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this profile? This action cannot be undone'**
  String get delete_message;

  /// No description provided for @my_tests.
  ///
  /// In en, this message translates to:
  /// **'My tests'**
  String get my_tests;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @score.
  ///
  /// In en, this message translates to:
  /// **'Score'**
  String get score;

  /// No description provided for @no_tests.
  ///
  /// In en, this message translates to:
  /// **'You have not completed any test yet'**
  String get no_tests;

  /// No description provided for @trial_completed.
  ///
  /// In en, this message translates to:
  /// **'You have completed the trial test. You will now attempt the official test. Which hand will you take the test with?'**
  String get trial_completed;

  /// No description provided for @well_done.
  ///
  /// In en, this message translates to:
  /// **'Well done!'**
  String get well_done;

  /// No description provided for @test_explanation.
  ///
  /// In en, this message translates to:
  /// **'Welcome to the symbols test. During the test, a symbol will appear in the middle of the screen. Your task is to find that symbol in the guide on the top of the screen and press the key with the number that matches the symbol. Once you press a key, regardless if it is the correct one or not, a new symbol will appear. Don\'t worry, before starting the official test you will attempt a 40 seconds test to get familiar with the test. After the trial, you will attempt the official 90 second test. Good luck!'**
  String get test_explanation;

  /// No description provided for @code_used.
  ///
  /// In en, this message translates to:
  /// **'This code has already been used to attempt the test. Please, ask your doctor for a new code'**
  String get code_used;

  /// No description provided for @unfinished_test.
  ///
  /// In en, this message translates to:
  /// **'Test uncomplete!'**
  String get unfinished_test;

  /// No description provided for @l.
  ///
  /// In en, this message translates to:
  /// **'L'**
  String get l;

  /// No description provided for @r.
  ///
  /// In en, this message translates to:
  /// **'R'**
  String get r;

  /// No description provided for @answers.
  ///
  /// In en, this message translates to:
  /// **'Answers'**
  String get answers;

  /// No description provided for @mistakes.
  ///
  /// In en, this message translates to:
  /// **'Mistakes'**
  String get mistakes;

  /// No description provided for @nickname_used.
  ///
  /// In en, this message translates to:
  /// **'This nickname is already on use. Please, try with a different one'**
  String get nickname_used;

  /// No description provided for @symbols.
  ///
  /// In en, this message translates to:
  /// **'Symbols'**
  String get symbols;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
