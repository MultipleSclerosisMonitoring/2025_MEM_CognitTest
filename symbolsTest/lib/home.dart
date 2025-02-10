import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers.dart';
import 'package:symbols/l10n/generated/l10n.dart';
import 'locale_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text(AppLocalizations.of(context)!.app_title),
        actions: [
          DropdownButton<Locale>(
            value: localeProvider.locale,
            icon: const Icon(Icons.language, color: Colors.white),
            dropdownColor: Colors.teal,
            onChanged: (Locale? newLocale) {
              if (newLocale != null) {
                localeProvider.setLocale(newLocale);
              }
            },
            items: const [
              DropdownMenuItem(
                value: Locale('en'),
                child: Text('🇺🇸 English', style: TextStyle(color: Colors.white)),
              ),
              DropdownMenuItem(
                value: Locale('es'),
                child: Text('🇪🇸 Español', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: Text(
                AppLocalizations.of(context)!.test_instructions,
                style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 30,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TimeProvider>().setStartTime();
                context.read<TimeProvider>().startTimer();
                Navigator.pushNamed(context, '/testScreen');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  AppLocalizations.of(context)!.start_test,
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resultsScreen');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    AppLocalizations.of(context)!.result_test,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
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
