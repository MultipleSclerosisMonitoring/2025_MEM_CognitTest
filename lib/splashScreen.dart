import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'dart:async';

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
      backgroundColor: Colors.white, // El color que quieras puede ser azul como xiaoYang
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset('assets/images/saludMadridPng.png', width: 150),// imagen del logo de salud madrid
            const SizedBox(height: 20),
            Image.asset('assets/images/upm.png', width: 120), // imagen del logo de UPM
            const SizedBox(height: 30),
            Text(_version, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}