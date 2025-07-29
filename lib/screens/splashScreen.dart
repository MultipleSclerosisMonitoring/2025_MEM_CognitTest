import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:symbols/utils/constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';

/// This class is for the splash screen, which displays while the app is launching
/// It displays the Comunidad de Madrid Salud logo
/// and the Universidad Politecnica de Madrid,
/// as well as the app version.
///
/// This class also collects the screen diagonal size in inches and saves it calling [DeviceProvider.setDiagonalInches]
class SplashScreen extends StatefulWidget {
  /// Builder of the class, creates the widget
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

/// Associated to [SplashScreen].
///
/// Handles the loading of the app version
class _SplashScreenState extends State<SplashScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();

    /// After building the widget, gets the diagonal size and saves it in the provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double diagInches = printScreenDiagonalInInches(context);
      context.read<DeviceProvider>().setDiagonalInches(diagInches);
    });

    /// Waits 5 seconds and navigates to the main screen
    Timer(const Duration(seconds: 5), () { //Duración de la permanencia en la pantalla de splash
      Navigator.pushReplacementNamed(context, '/'); // Aquí va a la pantalla principal
    });
  }

  /// Loads the app version and updates the version string
  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = info.toString();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.splashBackground, // El color que quieras puede ser azul como xiaoYang
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/saludMadridPng.png', width: 150),// imagen del logo de salud madrid
            const SizedBox(height: 20),
            Image.asset('assets/images/upm.png', width: 120), // imagen del logo de UPM
            const SizedBox(height: 30),
            Text(_version, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

/// Calculates and returns the screen's diagonal size in inches.
///
/// This is an approximation based on the device's logical size, pixel ratio,
/// and a base DPI assumption (typically 160 for Android).
double printScreenDiagonalInInches(BuildContext context) {
  final logicalWidth = MediaQuery.of(context).size.width;
  final logicalHeight = MediaQuery.of(context).size.height;
  final pixelRatio = MediaQuery.of(context).devicePixelRatio;

  /// Gets the real size of the screen in pixels
  final widthPx = logicalWidth * pixelRatio;
  final heightPx = logicalHeight * pixelRatio;

  /// Estimates the PPI (Pixels per inch) using the base of 160 dpi
  final ppi = 160 * pixelRatio;

  /// Calculates the diagonal
  final diagonalInches = sqrt(widthPx * widthPx + heightPx * heightPx) / ppi;

  debugPrint("la Diagonal aproximada de este dispositivo es: ${diagonalInches.toStringAsFixed(2)} pulgadas");
  return diagonalInches;
}