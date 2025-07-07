import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:symbols/constants.dart';
import 'dart:async';
import 'dart:math';
import 'package:symbols/providers.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String _version = '';

  @override
  void initState() {
    super.initState();
    _loadVersion();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      double diagInches = printScreenDiagonalInInches(context);
      context.read<DeviceProvider>().setDiagonalInches(diagInches);
    });
    Timer(const Duration(seconds: 2), () { //Duración de la permanencia en la pantalla de splash
      Navigator.pushReplacementNamed(context, '/'); // Aquí va a la pantalla principal
    });
  }

  Future<void> _loadVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _version = 'v${info.version}+${info.buildNumber}';
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


double printScreenDiagonalInInches(BuildContext context) {
  //// tamaño lógico
  final logicalWidth = MediaQuery.of(context).size.width;
  final logicalHeight = MediaQuery.of(context).size.height;
  final pixelRatio = MediaQuery.of(context).devicePixelRatio;

  /// tamaño real en píxeles
  final widthPx = logicalWidth * pixelRatio;
  final heightPx = logicalHeight * pixelRatio;

  // ppi aproximado(Android base es 160dpi)
  final ppi = 160 * pixelRatio;

  //// calcular la diagonal
  final diagonalInches = sqrt(widthPx * widthPx + heightPx * heightPx) / ppi;

  debugPrint("la Diagonal aproximada de este dispositivo es: ${diagonalInches.toStringAsFixed(2)} pulgadas");
  return diagonalInches;
}