import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import 'package:symbols/utils/constants.dart';

import '../utils/profile.dart';

class ProgressProvider extends ChangeNotifier{
  int progressCounter = 0;
  List <int> mistakesCounter = List.filled(3, 0);
  int totalMistakes = 0;
  List <int> symbolsDisplayed = List.filled(3,0);
  int totalDisplayed = 0;
  int thirdsCounter = 0;


  void incrementProgressCounter(){
    progressCounter++;
    notifyListeners();
  }

  void resetProgressCounter(){
    progressCounter = 0;
    notifyListeners();
  }


  void updateThirdsCounter(int elapsedMs, int limitMs){
    final newThird = (elapsedMs ~/ (limitMs / 3)).clamp(0,2);
    if (newThird != thirdsCounter) {
      thirdsCounter = newThird;
      notifyListeners();
    }
  }

  void resetThirdsCounter(){
    thirdsCounter = 0;
    notifyListeners();
  }

  void incrementMistakesCounter(int index){
    mistakesCounter[index]++;
    totalMistakes++;
    notifyListeners();
  }

  void resetMistakesCounter(){
    mistakesCounter = List.filled(3, 0);
    totalMistakes = 0;
    notifyListeners();
  }

  void incrementSymbolsDisplayed(int index){
    symbolsDisplayed[index]++;
    totalDisplayed++;
    notifyListeners();
  }

  void resetSymbolsDisplayed(){
    symbolsDisplayed = List.filled(3, 0);
    totalDisplayed = 0;
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


  void setFlag(bool f){
    keyFlag = f;
    notifyListeners();
  }
}

class TimeProvider extends ChangeNotifier{
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  Timer? testTimer;
  int limitMilliseconds = 0;
  bool isTestRunning = false;
  late DateTime startTime;
  List <int> partialTimes = [];
  bool isTimeStarted = false;

  int get elapsedMilliseconds => DateTime.now().difference(startTime).inMilliseconds;
  int get remaining => (limitMilliseconds - elapsedMilliseconds).clamp(0, limitMilliseconds);

  void setStartTime(){
    start = DateTime.now();
    notifyListeners();
  }
  void setEndTime(){
    end = DateTime.now();
    notifyListeners();
  }

  void startTimer({required int timeLimit, required VoidCallback onFinish, required ProgressProvider pp}) {
    testTimer?.cancel();
    startTime = DateTime.now();
    limitMilliseconds=  timeLimit;
    isTestRunning = true;

    //Incrementando a mano los intervalos de tiempo cada 100 ms (elapsed += 100) iba muy lento. Mejor con DateTime.now
    testTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      final currentElapsed = elapsedMilliseconds;



      if(currentElapsed >= timeLimit){
        testTimer!.cancel();
        isTestRunning = false;
        onFinish();
        notifyListeners();
        return;
      }
      pp.updateThirdsCounter(elapsedMilliseconds, limitMilliseconds);
      notifyListeners(); });
  }

  void addPartialTime(int i){
    partialTimes.add(i);
  }

  void resetPartialTimes(){
    partialTimes = [];
  }

  //Aqui se obtienen los tiempos parciales de verdad y se hace la media. No se hace antes por no añadir logica y entorpecer el reloj
  double getAveragedDuration(){
    for (int i = partialTimes.length - 1; i > 0; i--) {
      partialTimes[i] = partialTimes[i] - partialTimes[i - 1];
    }
    double result = partialTimes.reduce((a, b) => a + b) / partialTimes.length; //Media aritmetica
    return result;
  }

  double getStdDeviation(){
    for (int i = partialTimes.length - 1; i > 0; i--) {
    partialTimes[i] = partialTimes[i] - partialTimes[i - 1];
    }
    final average = partialTimes.reduce((a, b) => a + b) / partialTimes.length;
    final sumOfSquares = partialTimes
        .map((v) => pow(v - average, 2))
        .reduce((a, b) => a + b);
    return sumOfSquares/partialTimes.length;
  }

  void setIsTimeStarted(bool b){
    isTimeStarted = b;
    notifyListeners();
  }

}

class SymbolsProvider extends ChangeNotifier{
  bool shuffled = false;
  List <String> symbols =  [];
  int trialCounter = 0;
  List <int> trialOrder = [];
  int id = Random().nextInt(9); //Del 0 al 8

  void changeActiveId({required int newId}) /*async*/ {
    id = newId;
    notifyListeners();
  }

  void setSymbols(bool isSymbols1){
    //De esta manera (List<String>.from), se permite modificar la lista
    symbols = List<String>.from(isSymbols1 ? GeneralConstants.symbols1 : GeneralConstants.symbols2);
    notifyListeners();
  }

  //Con esta funcion nos aseguramos que se reordenen los simbolos solo una vez y se queden asi
  List <String> getSymbols(){
    if(!shuffled){
      symbols.shuffle(Random());
      shuffled = true;
    }
    return symbols;
  }

  void setShuffled(bool b){
    shuffled = b;
    notifyListeners();
  }

  void incrementTrialCounter(){
    trialCounter++;
    notifyListeners();
  }

  void resetTrialCounter(){
    trialCounter = 0;
    notifyListeners();
  }

  void generateNewOrder(){
    trialOrder = List<int>.generate(9, (i) => i)..shuffle(Random());
    print(trialOrder);
    notifyListeners();
  }
}

class ParametersProvider extends ChangeNotifier{
  bool saveButtonPressed = false;
  String? hand; //'L' o 'R'
  String? codeid;
  TextEditingController codeidController1 = TextEditingController();
  TextEditingController codeidController2 = TextEditingController();
  bool dataSent = false;
  bool dataSentCorrectly = false;
  bool isTrialTest = true;



  void setIsTrialTest(bool b){
    isTrialTest = b;
    notifyListeners();
  }


  void setCodeid(String c){
    codeid = c;
    notifyListeners();
  }



  void setDataSent(bool d){
    dataSent = d;
    notifyListeners();
  }

  void setDataSentCorrectly(bool d){
    dataSentCorrectly = d;
    notifyListeners();
  }



  void setHand (String h){
    hand = h;
    notifyListeners();
  }

  void setSaveButtonPressed(bool x){
    saveButtonPressed = x;
    notifyListeners();
  }

  void resetCodeidController1(){
    codeidController1 = TextEditingController();
    notifyListeners();
  }
  void resetCodeidController2(){
    codeidController2 = TextEditingController();
    notifyListeners();
  }

}

class PersonalDataProvider extends ChangeNotifier{
  bool editingMode = false;
  int profileCounter = 0;
  int? activeUser;
  List<Profile> profilesList = [];
  Profile tempUser = Profile();
  TextEditingController dataController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  

  void addNewProfile(Profile newUser){
    profilesList.add(newUser);
    profileCounter++;
    notifyListeners();
  }

  void updateProfile(int index, Profile u){
    profilesList[index] = u;
    notifyListeners();
  }

  void setActiveUser(int? a){
    activeUser = a;
    notifyListeners();
  }


  void setTempSex(String s){
    tempUser.sex = s;
    notifyListeners();
  }

  void setTempLevelOfStudies (String l){
    tempUser.levelOfStudies = l;
    notifyListeners();
  }

  void setTempNickname(String n){
    tempUser.nickname = n;
    notifyListeners();
  }

  void setTempIsSymbols1(bool b){
    tempUser.isSymbols1 = b;
    notifyListeners();
  }

  void resetTempUser(){
    tempUser = Profile();
    notifyListeners();
  }

  void resetProfilesProvider(){
    profilesList = [];
    notifyListeners();
  }

  void resetNicknameController(){
    nicknameController = TextEditingController();
    notifyListeners();
  }

  void resetDataController(){
    dataController = TextEditingController();
    notifyListeners();
  }

  void setEditingMode(bool e){
    editingMode = e;
    notifyListeners();
  }


  Future<void> saveProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> profilesJson =
    profilesList.map((profile) => jsonEncode(profile.toJson())).toList();

    await prefs.setStringList('profiles', profilesJson);
    print('Saved: $profilesJson');
    await prefs.setBool('dataExists', true);

  }

  Future<void> loadProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    print('load checkpoint');
    List<String>? profilesJson = prefs.getStringList('profiles');
    if (profilesJson != null) {
      profilesList = profilesJson
          .map((profile) => Profile.fromJson(jsonDecode(profile)))
          .toList();
      profileCounter = profilesList.length;
      print('Loaded: $profilesJson');
    }


  }


}

class ButtonsProvider extends ChangeNotifier{

  bool isUserSelected = false;
  bool isCodeValidated = false;
  bool isReadOnly = false;
  bool wrongCodeId = false;

  void setWrongCodeid(bool w){
    wrongCodeId = w;
    notifyListeners();
  }

  void setIsUserSelected(bool i){
    isUserSelected = i;
    notifyListeners();
  }

  void setIsReadOnly (bool i){
    isReadOnly = i;
    notifyListeners();
  }

  void setIsCodeValidated (bool i){
    isCodeValidated = i;
    notifyListeners();
  }

  void toggleIsUserSelected(){
    isUserSelected = !isUserSelected;
    notifyListeners();
  }

  void toggleIsCodeValidated(){
    isCodeValidated = !isCodeValidated;
    notifyListeners();
  }

  void toggleIsReadOnly(){
    isReadOnly = !isReadOnly;
    notifyListeners();
  }



}

class DeviceProvider extends ChangeNotifier{
  String? deviceModel;
  double? diagonalInches;

  void setDeviceModel(String s){
    deviceModel = s;
    notifyListeners();
  }
  void setDiagonalInches(double d){
    diagonalInches = d;
    notifyListeners();
  }



}

