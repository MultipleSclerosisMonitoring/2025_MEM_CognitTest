import 'dart:ui';
import 'package:flutter/material.dart';


class AppColors{
  static const Color primaryBlue = Color(0xFF3086CF);
  static const Color secondaryBlue = Color(0xFFE8F1FA);
  static const Color secondaryBlueClear = Color(0xFFF8F9FE);
  static const Color blueText = Color(0xFF0E47A1);
  static const Color splashBackground = Color(0xFF4090E5);

  Color getBlueText(){
    return blueText;
  }
}

class GeneralConstants{
  static const int trialDuration = 40000;
  static const int testDuration = 90000;
  static const int countDownDuration = 1;
  static const int toolbarHeightRatio = 8;
  static const List <String> symbols1 =  ['⊂','⨪','⊢','ᒥ','⊣','>','+','⊃','∸'];
  static const String symbols1String = '⊂ ⨪ ⊢ ᒥ ⊣ > + ⊃ ∸';
  static const List <String> symbols2 =  ['△','+','☆','○','□','⊞','≡','∞','×'];
  static const String symbols2String = '△ + ☆ ○ □ ⊞ ≡ ∞ ×';
}

class TestConstants{
  static const int numberKeyHeightRatio = 12;
  static const double keyHorizontalPadding = 40.0;
  static const double keyboardHorizontalPadding = 16.0;
  static const double centralSymbolSize = 130;
}

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



