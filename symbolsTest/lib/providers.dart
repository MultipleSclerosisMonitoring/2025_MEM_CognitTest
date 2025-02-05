import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';

class IdProvider extends ChangeNotifier{
  int id = 1;

  void changeActiveId({required int newId}) /*async*/ {
    id = newId;
    notifyListeners();
  }
}

class ProgressProvider extends ChangeNotifier{
  int progressCounter = 0;
  List <int> mistakesCounter = List.filled(30, 0);

  void incrementProgressCounter(){
    progressCounter++;
    notifyListeners();
  }

  void incrementMistakesCounter(int index){
    mistakesCounter[index]++;
    notifyListeners();
  }
}

class KeyboardProvider extends ChangeNotifier{
  int keyPressed = 0;
  bool keyFlag = false;

  void changeKeyPressed({required int newKey}) /*async*/{
    keyPressed = newKey;
    notifyListeners();
  }

  void toggleFlag() /*async*/{
    keyFlag = !keyFlag;
    notifyListeners();
  }
}

class TimeProvider extends ChangeNotifier{
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  Stopwatch timer = Stopwatch();
  List <int> partialTimes =  List.filled(30, 0);
  int previousTime = 0;

  void setStartTime(){
    start = DateTime.now();
    notifyListeners();
  }
  void setEndTime(){
    end = DateTime.now();
    notifyListeners();
  }

  void startTimer(){
    timer.start();
    notifyListeners();
  }
  void stopTimer(){
    timer.stop();
    notifyListeners();
  }

  void setPartialTime(int index){
    int timeNow = timer.elapsedMilliseconds;
    partialTimes[index] = timeNow - previousTime;
    previousTime = timeNow;
    notifyListeners();
  }

}

class SymbolsProvider extends ChangeNotifier{
  int numberOfSymbols = 0;
  bool shuffled = false;
  List <String> symbols =  ['×', '○', '+', '☆', '△', '□', '≡', '∞', '⊞',];

  //Con esta funcion nos aseguramos que se reordenen los simbolos solo una vez y se queden asi
  List <String> getSymbols(){
    if(!shuffled){
      symbols.shuffle(Random());
      shuffled = true;
    }
    return symbols;
  }
}

