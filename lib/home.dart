import 'package:flutter/material.dart';
import 'providers.dart';
import 'package:provider/provider.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override

  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Mi primera aplicacion'),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Padding(
              padding:  EdgeInsets.all(40.0),
              child:  Text(
                    'TEST INSTRUCTIONS: Match the symbol on the screen with its corresponding number using the keyboard on the bottom.'
                    ' Click on the botton below to start the test.',
                    style: TextStyle(color: Colors.teal, fontSize: 30, ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<TimeProvider>().setStartTime();
                context.read<TimeProvider>().startTimer();
                Navigator.pushNamed(context, '/testScreen');

              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,),
              child: const Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                    'START TEST',
                     style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(40.0),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/resultsScreen');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.teal,),
                child: const Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'Go to results',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
