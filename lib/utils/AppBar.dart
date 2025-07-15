

import 'package:flutter/material.dart';
import 'package:symbols/state_management/locale_provider.dart';

import 'constants.dart';

AppBar getGeneralAppBar(BuildContext context, LocaleProvider localeProvider, bool goBack){
  return AppBar(
    automaticallyImplyLeading: goBack,
    toolbarHeight: MediaQuery.of(context).size.height / GeneralConstants.toolbarHeightRatio,
    backgroundColor: Colors.white,
    //leading: Image.asset('assets/images/saludmadrid.jpg'),
    actions:[ Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/saludMadridPng.png'),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/images/upm.png'),
            ),
          ),
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
                  onChanged: (Locale? newLocale) {
                    if (newLocale != null) {
                      localeProvider.setLocale(newLocale);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: Locale('en'),
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('🇺🇸',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
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

AppBar getTestAppBar(BuildContext context, String minutes, String seconds){
  return AppBar(
    automaticallyImplyLeading: false,
    toolbarHeight: MediaQuery
        .of(context)
        .size
        .height / GeneralConstants.toolbarHeightRatio,
    backgroundColor: Colors.white,
    //leading: Image.asset('assets/images/saludmadrid.jpg'),
    actions: [ Expanded(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Image.asset('assets/images/saludMadridPng.png'),
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image.asset('assets/images/upm.png'),
            ),
          ),
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('$minutes:$seconds',
                    style: TextStyle(
                        color: AppColors().getBlueText(),
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