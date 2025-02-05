import 'package:flutter/material.dart';
import 'package:symbols/resultsScreen.dart';
import 'providers.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import 'testScreen.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => IdProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => ProgressProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => KeyboardProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => TimeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SymbolsProvider(),
        )
      ],
      child: MaterialApp(
        initialRoute: '/',
        routes: {
          '/': (context) => const HomePage(),
          '/testScreen': (context) => const CognitionTestScreen(),
          '/resultsScreen': (context) => const ResultsScreen(),
        },
      ),
    );
  }
}

