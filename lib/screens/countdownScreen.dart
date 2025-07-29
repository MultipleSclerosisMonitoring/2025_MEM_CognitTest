import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';

/// This class is used for a countdown from 3 that displays before the test starts.
/// When navigating to this page, it is required to pass as arguments a series of
/// instructions to be executed when the countdown finishes
class CountdownScreen extends StatefulWidget {
  /// Builder function
  const CountdownScreen({Key? key}) : super(key : key);
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

/// Associated to [CountdownScreen], it manages the animation and the countdown
class _CountdownScreenState extends State<CountdownScreen>
    with SingleTickerProviderStateMixin {
  /// Number showing in the countdown
  int _currentNumber = 3;
  /// Controller for the animation to escalates the number
  late AnimationController _controller;
  /// Animation that enlarges and diminishes the size of the number
  late Animation<double> _scaleAnimation;
  /// Function to execute when the countdown finishes
  late VoidCallback onFinish;

  /// Initializes the animation and gets the callback [onFinish] from the arguments of the route
  @override
  void initState() {
    super.initState();

    /// Gets the instructions for when the countdown finishes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onFinish = ModalRoute.of(context)!.settings.arguments as VoidCallback;
    });

    /// Creates the animation controller with a duration of 800 ms.
    _controller = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    /// Defines the animation: from 0.5x to 1.5x  with a smooth curve
    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    /// Starts the countdown logic
    _startCountdown();
  }

  /// Starts the countdown. After finishing, calls [onFinish]
  void _startCountdown() async {
    for (int i = 3; i >= 1; i--) {
      setState(() {
        _currentNumber = i;
      });

      _controller.forward(from: 0); // Reproduce la animación
      /// Waits one second between numbers
      await Future.delayed(const Duration(seconds: GeneralConstants.countDownDuration));
    }

    // Después del 1, navegamos a la siguiente página
    /// Calls [onFinish] when finished
    if (mounted) {
        onFinish();
    }
  }

  /// Liberates animation resources after destroying the widget
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  /// Builds the interface
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

