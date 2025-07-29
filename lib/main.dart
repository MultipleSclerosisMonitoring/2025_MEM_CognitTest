import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbols/screens/countdownScreen.dart';
import 'package:symbols/screens/resultsScreen.dart';
import 'package:symbols/screens/splashScreen.dart';
import 'screens/newProfileScreen.dart';
import 'state_management/providers.dart';
import 'package:provider/provider.dart';
import 'screens/homeScreen.dart';
import 'state_management/locale_provider.dart';
import 'screens/testScreen.dart';
import 'l10n/generated/l10n.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'dart:io';

/// This is the main function executed to launch the app.
/// First it creates a [PersonalDataProvider] and a [DeviceProvider]. The reason only these
/// providers are instanced before the builder is called is to obtain the model of the device
/// using [obtenerModelo] and load the profiles stored in [SharedPreferences]
/// using [PersonalDataProvider.loadProfiles] before displaying the home page.
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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

/// This class is the app itself, and its passed as an argument to [runApp] to launch the app.
/// Requires as arguments a [PersonalDataProvider] and a [DeviceProvider] since they are
/// built before running the app.
class MyApp extends StatelessWidget {
  final PersonalDataProvider personalDataProvider;
  final DeviceProvider deviceProvider;
  /// App builder. It returns a [MultiProvider], creating all new providers except [DeviceProvider] and [PersonalDataProvider]
  /// that are already created
  const MyApp({super.key, required this.personalDataProvider, required this.deviceProvider});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
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

        //DeviceProvider y PersonalDataProvider son distintos porque se usan ya en el main al iniciar la app

      ],
      child: Builder(builder: (context) {
        final localeProvider = Provider.of<LocaleProvider>(context);

        return MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          locale: localeProvider.locale,
          initialRoute: '/splashScreen',
          routes: {
            '/': (context) => const HomeScreen(),
            '/splashScreen': (context) => const SplashScreen(),
            '/testScreen': (context) => const TestScreen(),
            '/resultsScreen': (context) => const ResultsScreen(),
            '/newProfileScreen': (context) => NewProfileScreen(),
            '/countdownScreen': (context) => CountdownScreen(),
          },
        );
      }),
    );
  }
}

/// This function is used to obtain the model of the device the app is being launched in
/// It requires as an argument the [DeviceProvider] to call [DeviceProvider.setDeviceModel]
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