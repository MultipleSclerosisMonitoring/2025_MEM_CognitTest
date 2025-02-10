import 'package:flutter/material.dart';
import 'package:symbols/resultsScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:symbols/l10n/generated/l10n.dart';
import 'providers.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'testScreen.dart';
import 'locale_provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => IdProvider()),
        ChangeNotifierProvider(create: (context) => ProgressProvider()),
        ChangeNotifierProvider(create: (context) => KeyboardProvider()),
        ChangeNotifierProvider(create: (context) => TimeProvider()),
        ChangeNotifierProvider(create: (context) => SymbolsProvider()),
        ChangeNotifierProvider(create: (context) => LocaleProvider()),
      ],
      child: Builder(builder: (context) {
        final localeProvider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          initialRoute: '/',
          routes: {
            '/': (context) => const HomePage(),
            '/testScreen': (context) => const CognitionTestScreen(),
            '/resultsScreen': (context) => const ResultsScreen(),
          },
        );
      }),
    );
  }
}
