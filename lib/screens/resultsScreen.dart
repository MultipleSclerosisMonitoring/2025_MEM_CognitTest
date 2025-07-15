import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/l10n/generated/l10n.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';

import '../utils/AppBar.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final deviceProvider = Provider.of<DeviceProvider>(context);
    bool dataOK = parametersProvider.dataSentCorrectly;

    return Scaffold(
      appBar: getGeneralAppBar(context, localeProvider, false),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.indigo, width: 3),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: AutoSizeText(
                      dataOK == true ? AppLocalizations.of(context)!.test_finished.toUpperCase() : AppLocalizations.of(context)!.test_finished_wrong.toUpperCase(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                        fontSize: 40,
                      ),
                      softWrap: true,
                      overflow: TextOverflow.visible,
                     // textAlign: TextAlign.justify,
                    ),
                  ),
                ),
              ),
            ),
            Flexible(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: ElevatedButton(
                  onPressed: () {
                  Navigator.pushNamed(context, '/');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  child: const Padding(
                    padding: EdgeInsets.all(16.0),
                    child:
                      Icon(Icons.home, size: 100,color: Colors.white,)
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}



