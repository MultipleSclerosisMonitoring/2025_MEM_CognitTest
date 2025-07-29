import 'package:flutter/material.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'constants.dart';

/// Returns an AppBar receiving as an argument the [context] to access the providers, the [localeProvider] to implement the language button,
/// and a boolean [goBack] that indicates if the AppBar should include the arrow icon to go to the previous page.
///
/// The AppBar includes a dropdown menu with English and Spanish language:
/// when one is selected, it calls [LocaleProvider.setLocale] passing the selected language as argument.
AppBar getGeneralAppBar(BuildContext context, LocaleProvider localeProvider, bool goBack){
  return AppBar(
    automaticallyImplyLeading: goBack,
    /// The height depends on the constant defined in the constants file
    toolbarHeight: MediaQuery.of(context).size.height / GeneralConstants.toolbarHeightRatio,
    backgroundColor: Colors.white,
    actions:[ Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Comunidad de Madrid Salud logo
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/saludMadridPng.png'),
            ),
          ),
          /// Universidad Politecnica de Madrid logo
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/images/upm.png'),
            ),
          ),
          /// Dropdown button to select the language
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.red,
                child: DropdownButton<Locale>(
                  value: localeProvider.locale,
                  icon: const Padding(
                    padding:  EdgeInsets.all(8.0),
                    child:  Icon(Icons.language, color: Colors.white),
                  ),
                  dropdownColor: Colors.red,
                  /// Assigning language to the localeProvider
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      localeProvider.setLocale(newLocale);
                    }
                  },
                  items: const [
                    /// The English language is represented with a USA flag
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('🇺🇸',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    /// The Spanish language is represented with a Spanish flag
                    DropdownMenuItem(
                      value: Locale('es'),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('🇪🇸',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
    ],
  );
}

/// Returns the test screen AppBar receiving as an argument the [context] to access the providers,
/// and the strings [minutes] and [seconds] that indicate how much time is left in the test.
///
/// This AppBar differs from the rest because it does not include language selection menu but includes a clock
/// The return arrow is not included in this AppBar
AppBar getTestAppBar(BuildContext context, String minutes, String seconds){
  return AppBar(
    automaticallyImplyLeading: false,
    /// The height depends on the constant defined in the constants file
    toolbarHeight: MediaQuery.of(context).size.height / GeneralConstants.toolbarHeightRatio,
    backgroundColor: Colors.white,
    actions: [ Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /// Comunidad de Madrid Salud logo
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/saludMadridPng.png'),
            ),
          ),
          /// Universidad Politecnica de Madrid logo
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/images/upm.png'),
            ),
          ),
          /// Clock showing the remaining test time
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$minutes:$seconds',
                    style: const TextStyle(
                        color: AppColors.blueText,
                        fontSize: 30
                    )),
              ],
            ),
          ),
        ],
      ),
    ),
    ],
  );
}