import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';

class CountdownScreen extends StatefulWidget {
  const CountdownScreen({Key? key}) : super(key : key);
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen>
    with SingleTickerProviderStateMixin {
  int _currentNumber = 3;
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late VoidCallback onFinish;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      onFinish = ModalRoute.of(context)!.settings.arguments as VoidCallback;
    });
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _startCountdown();
  }

  void _startCountdown() async {
    for (int i = 3; i >= 1; i--) {
      setState(() {
        _currentNumber = i;
      });

      _controller.forward(from: 0); // Reproduce la animación
      await Future.delayed(const Duration(seconds: GeneralConstants.countDownDuration));
    }

    // Después del 1, navegamos a la siguiente página
    if (mounted) {
        onFinish();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (_, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Text(
                '$_currentNumber',
                style: TextStyle(
                  fontSize: 120,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

