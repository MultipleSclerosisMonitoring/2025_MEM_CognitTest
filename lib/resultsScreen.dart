import 'package:flutter/material.dart';
import 'providers.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key});

  @override
  Widget build(BuildContext context) {

    List <int> errors = context.watch<ProgressProvider>().mistakesCounter;
    List <int> times = context.watch<TimeProvider>().partialTimes;

    List <Widget> resultLinesLeft = buildResults(1, 15, errors, times);
    List <Widget> resultLinesRight = buildResults(16, 30, errors, times);

    DateTime startTime = context.watch<TimeProvider>().start;
    DateTime endTime = context.watch<TimeProvider>().end;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Results '),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...resultLinesLeft,
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ...resultLinesRight,
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Fecha y hora de comienzo: ${DateFormat('yyyy-MM-dd – HH:mm').format(startTime)};',
                  style: const TextStyle(backgroundColor: Colors.white, color: Colors.teal, fontSize: 18),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Fecha y hora de finalización: ${DateFormat('yyyy-MM-dd – HH:mm').format(endTime)};',
                  style: const TextStyle(backgroundColor: Colors.white, color: Colors.teal, fontSize: 18),
                ),
              ),
                          ],
          ),
        ],
      ),
    );
  }
}


List <Widget> buildResults(int start, int end, List <int> errors, List <int> times){
  List <Widget> textLines = [];
  for(int i = start - 1; i < end; i++){
    textLines.add(
        Text(
          'Intento ${i+1}: ${errors[i]} erroreCs en ${times[i]~/1000}:${times[i]%1000} segundos',
           style: const TextStyle(backgroundColor: Colors.white, color: Colors.teal, fontSize: 16),
          )
    );
  }
  return textLines;
}

