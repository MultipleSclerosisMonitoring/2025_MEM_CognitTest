import 'dart:ui';
import 'package:flutter/material.dart';

/// Contains the principal colors whose use is repeated throughout the app
class AppColors{
  /// Used for the reference code field
  static const Color primaryBlue =  Color(0xFF3086CF);
  /// Background of buttons in home screen and keys in the numeric keyboard
  static const Color secondaryBlue = Color(0xFFE8F1FA);
  /// Used for the outside of the home screen buttons
  static const Color secondaryBlueClear = Color(0xFFF8F9FE);
  /// For the majority of texts in the app
  static const Color blueText = Color(0xFF0E47A1);
  /// Background of the loading screen
  static const Color splashBackground = Color(0xFF4090E5);


}

/// Miscellaneous of parameters used in the app
class GeneralConstants{
  /// Duration in milliseconds of the trial test
  static const int trialDuration = 40000;
  /// Duration in milliseconds of the official test
  static const int testDuration = 90000;
  /// Seconds each number is on screen in the countdown
  static const int countDownDuration = 1;
  /// Ratio by which the total screen height is divided to obtain the appbar height
  static const int toolbarHeightRatio = 8;
  /// Set of symbols number 1
  static const List <String> symbols1 =  ['⊂','⨪','⊢','ᒥ','⊣','>','+','⊃','∸'];
  static const String symbols1String = '⊂ ⨪ ⊢ ᒥ ⊣ > + ⊃ ∸';
  /// Set of symbols number 2
  static const List <String> symbols2 =  ['△','+','☆','○','□','⊞','≡','∞','×'];
  static const String symbols2String = '△ + ☆ ○ □ ⊞ ≡ ∞ ×';
}

/// Parameters used in the test screen
class TestConstants{
  /// Ratio by which the total screen height is divided to obtain the height of each key in the numeric keyboard
  static const int numberKeyHeightRatio = 12;
  /// Horizontal padding for the reference key
  static const double keyHorizontalPadding = 40.0;
  /// Horizontal padding for the numeric keyboard
  static const double keyboardHorizontalPadding = 16.0;
  /// Font size for the central symbol
  static const double centralSymbolSize = 130;
}

/// Parameters used in the new profile screen
class NewProfileConstants{
  /// The main column padding
  static const EdgeInsets _generalPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 20);
  /// Padding for each field's title
  static const EdgeInsets _titlePadding = EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0);
  /// Padding for the fields (TextField or Dropdown)
  static const EdgeInsets _fieldPadding = EdgeInsets.symmetric(horizontal: 16);
  /// Padding for the text inside the dropdown
  static const EdgeInsets _dropdownPadding = EdgeInsets.all(8);
  /// Padding for the save and delete buttons
  static const EdgeInsets _buttonsPadding = EdgeInsets.fromLTRB(16.0, 16.0, 16.0 ,4.0);
  /// Padding for the text inside the save and delete buttons
  static const EdgeInsets _buttonsTextPadding = EdgeInsets.all(16);
  /// Padding for the text inside the dropdown and text fields
  static const EdgeInsets _innerPadding = EdgeInsets.all(4);
  /// Corner radius for the boxes that encapsulate fields
  static const double radius = 8;
  /// Width of the boxes that encapsulate the fields
  static const double boxWidth = 3;
  /// Width for the dropdowns
  static const double dropdownWidth = 1;

  EdgeInsets get generalPadding => _generalPadding;
  EdgeInsets get titlePadding => _titlePadding;
  EdgeInsets get fieldPadding => _fieldPadding;
  EdgeInsets get dropdownPadding => _dropdownPadding;
  EdgeInsets get buttonsPadding => _buttonsPadding;
  EdgeInsets get buttonsTextPadding => _buttonsTextPadding;
  EdgeInsets get innerPadding => _innerPadding;
}

/// Parameters used in the home screen
class HomeConstants{
  /// Corner radius for the buttons
  static const double buttonRadius = 15;
  /// Size of the lock icon when buttons are unavailable
  static const double lockSize = 40;
  /// Opacity ratio when buttons are unavailable
  static const double opacity = 0.2;
  /// Text height (for each line) in relation to the button total height
  static const double buttonTextHeightRatio = 0.3;
  /// Padding for the buttons
  static const double buttonPadding = 12;
  /// Padding for the text inside the buttons
  static const double buttonTextPadding = 8;
  /// Ratio by which the total screen height is divided to obtain the button height
  static const double buttonHeightRatio = 7;
  /// Font size for the texts in "view my tests"
  static const double viewMyTestsFont = 16;
  /// Corner radius for the reference code field
  static const double codeIdRadius = 7;
}



