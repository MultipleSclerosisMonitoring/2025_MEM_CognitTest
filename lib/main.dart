import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbols/countdownScreen.dart';
import 'package:symbols/resultsScreen.dart';
import 'package:symbols/splashScreen.dart';
import 'newProfileScreen.dart';
import 'providers.dart';
import 'package:provider/provider.dart';
import 'homeScreen.dart';
import 'locale_provider.dart';
import 'testScreen.dart';
import 'l10n/generated/l10n.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  /*
  await Future.delayed(Duration(seconds: 2)); // Simula carga
  FlutterNativeSplash.remove(); // Quita el splash

   */
  final prefs = await SharedPreferences.getInstance();
  final personalDataProvider = PersonalDataProvider();
  final deviceProvider = DeviceProvider();
  bool dataExists = await prefs.getBool('dataExists') ?? false;
  if(dataExists == true) {
    await personalDataProvider.loadProfiles();
  }
  await obtenerModelo(deviceProvider);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp( MyApp(personalDataProvider: personalDataProvider, deviceProvider: deviceProvider,));
}

class MyApp extends StatelessWidget {
  final PersonalDataProvider personalDataProvider;
  final DeviceProvider deviceProvider;
  const MyApp({super.key, required this.personalDataProvider, required this.deviceProvider});
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
        ),
        ChangeNotifierProvider(
          create: (context) => ParametersProvider(),
        ),
        ChangeNotifierProvider(
            create: (context) => LocaleProvider(),
        ),
        ChangeNotifierProvider<PersonalDataProvider>.value(
          value: personalDataProvider, //Carga los perfiles del sharedPreferences al abrir la app
        ),
        ChangeNotifierProvider(
          create: (context) => ButtonsProvider(),
        ),
        ChangeNotifierProvider<DeviceProvider>.value(
          value: deviceProvider,
        ),

        //DeviceProvider y PersonalDataPRovider son distintos porque se usan ya en el main al iniciar la app

      ],
      child: Builder(builder: (context) {
        final localeProvider = Provider.of<LocaleProvider>(context);



        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          initialRoute: '/splashScreen',
          routes: {
           // '/': (context) => const UserSelectionScreen(),
            '/': (context) => const HomeScreen(),
            '/splashScreen': (context) => const SplashScreen(),
            '/testScreen': (context) => const CognitionTestScreen(),
            '/resultsScreen': (context) => const ResultsScreen(),
            '/newProfileScreen': (context) => NewProfileScreen(),
            '/countdownScreen': (context) => CountdownScreen(),
          },
        );
      }),
    );
  }
}

Future<void> obtenerModelo(DeviceProvider dp) async {
  final deviceInfo = DeviceInfoPlugin();

  if (Platform.isAndroid) {
    final info = await deviceInfo.androidInfo;
    print('Modelo: ${info.model}');
    print('Marca: ${info.brand}');
    print('Android: ${info.version.release}');
    dp.setDeviceModel( '${info.model}' + '${info.brand}' + '${info.version.release}');
  } else if (Platform.isIOS) {
    final info = await deviceInfo.iosInfo;
    print('Modelo: ${info.utsname.machine}');
    print('Nombre: ${info.name}');
    print('iOS: ${info.systemVersion}');
    dp.setDeviceModel( '${info.utsname.machine}' + '${info.name}' + '${info.systemVersion}');
  }
}