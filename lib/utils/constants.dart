import 'dart:ui';
import 'package:flutter/material.dart';

/// Contains the principal colors whose use is repeated throughout the app. Its fields are
///
/// [primaryBlue] Used for the reference code field
/// [secondaryBlue] The background of buttons in home screen and keys in the numeric keyboard
/// [secondaryBlueClear] Used for the outside of the home screen buttons
/// [blueText] For the majority of texts in the app
/// [splashBackground] The background of the loading screen
class AppColors{
  static const Color primaryBlue =  Color(0xFF3086CF);
  static const Color secondaryBlue = Color(0xFFE8F1FA);
  static const Color secondaryBlueClear = Color(0xFFF8F9FE);
  static const Color blueText = Color(0xFF0E47A1);
  static const Color splashBackground = Color(0xFF4090E5);


}

/// Miscellaneous of parameters used in the app. Its fields are
///
/// [trialDuration] Duration in milliseconds of the trial test
/// [testDuration] Duration in milliseconds of the official test
/// [countDownDuration] Seconds each number is on screen in the countdown
/// [toolbarHeightRatio] Ratio by which the total screen height is divided to obtain the appbar height
/// [symbols1] Set of symbols number 1
/// [symbols1String] Symbols1 as an only string
/// [symbols2] Set of symbols number 2
/// [symbols2String] Symbols 2 as an only string
/// [appVersion] Version number of the app
class GeneralConstants{
  static const int trialDuration = 90000;
  static const int testDuration = 90000;
  static const int countDownDuration = 1;
  static const int toolbarHeightRatio = 8;
  static const List <String> symbols1 =  ['⊂','⨪','⊢','ᒥ','⊣','>','+','⊃','∸'];
  static const String symbols1String = '⊂ ⨪ ⊢ ᒥ ⊣ > + ⊃ ∸';
  static const List <String> symbols2 =  ['△','+','☆','○','□','⊞','≡','∞','×'];
  static const String symbols2String = '△ + ☆ ○ □ ⊞ ≡ ∞ ×';
  static const String appVersion = '1.1.4';
}

/// Parameters used in the test screen. Its fields are
///
/// [numberKeyHeightRatio] Ratio by which the total screen height is divided to obtain the height of each key in the numeric keyboard
/// [keyHorizontalPadding] Horizontal padding for the reference key
/// [keyboardHorizontalPadding] Horizontal padding for the numeric keyboard
/// [centralSymbolSize] Font size for the central symbol
class TestConstants{
  static const int numberKeyHeightRatio = 12;
  static const double keyHorizontalPadding = 40.0;
  static const double keyboardHorizontalPadding = 16.0;
  static const double centralSymbolSize = 130;
}

/// Parameters used in the new profile screen. Its fields are
///
/// [_generalPadding] The main column padding
/// [_titlePadding] Padding for each field's title
/// [_fieldPadding] Padding for the fields (TextField or Dropdown)
/// [_dropdownPadding] Padding for the text inside the dropdown
/// [_buttonsPadding] Padding for the save and delete buttons
/// [_buttonsTextPadding] Padding for the text inside the save and delete buttons
/// [_innerPadding] Padding for the text inside the dropdown and text fields
/// [radius] Corner radius for the boxes that encapsulate fields
/// [boxWidth] Width of the boxes that encapsulate the fields
/// [dropdownWidth] Width for the dropdowns

class NewProfileConstants{
  static const EdgeInsets _generalPadding = EdgeInsets.symmetric(horizontal: 16, vertical: 20);
  static const EdgeInsets _titlePadding = EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0);
  static const EdgeInsets _fieldPadding = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets _dropdownPadding = EdgeInsets.all(8);
  static const EdgeInsets _buttonsPadding = EdgeInsets.fromLTRB(16.0, 16.0, 16.0 ,4.0);
  static const EdgeInsets _buttonsTextPadding = EdgeInsets.all(16);
  static const EdgeInsets _innerPadding = EdgeInsets.all(4);
  static const double radius = 8;
  static const double boxWidth = 3;
  static const double dropdownWidth = 1;

  EdgeInsets get generalPadding => _generalPadding;
  EdgeInsets get titlePadding => _titlePadding;
  EdgeInsets get fieldPadding => _fieldPadding;
  EdgeInsets get dropdownPadding => _dropdownPadding;
  EdgeInsets get buttonsPadding => _buttonsPadding;
  EdgeInsets get buttonsTextPadding => _buttonsTextPadding;
  EdgeInsets get innerPadding => _innerPadding;
}

/// Parameters used in the home screen. Its fields are
///
/// [buttonRadius] Corner radius for the buttons
/// [lockSize] Size of the lock icon when buttons are unavailable
/// [opacity] Opacity ratio when buttons are unavailable
/// [buttonTextHeightRatio] Text height (for each line) in relation to the button total height
/// [buttonPadding] Padding for the buttons
/// [buttonTextPadding] Padding for the text inside the buttons
/// [buttonHeightRatio] Ratio by which the total screen height is divided to obtain the button height
/// [viewMyTestsFont] Font size for the texts in "view my tests"
/// [codeIdRadius] Corner radius for the reference code field

class HomeConstants{
  static const double buttonRadius = 15;
  static const double lockSize = 40;
  static const double opacity = 0.2;
  static const double buttonTextHeightRatio = 0.3;
  static const double buttonPadding = 12;
  static const double buttonTextPadding = 8;
  static const double buttonHeightRatio = 7;
  static const double viewMyTestsFont = 16;
  static const double codeIdRadius = 7;
}



