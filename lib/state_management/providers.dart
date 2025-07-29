import 'dart:async';
import 'dart:core';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:symbols/screens/homeScreen.dart';
import 'package:symbols/screens/newProfileScreen.dart';
import 'dart:convert';

import 'package:symbols/utils/constants.dart';

import '../utils/profile.dart';

/// This provider manages the data related to the progress of the test.
/// For some metrics the test is divided in thirds: three parts of 30 seconds each.
///
/// This class fields are:
///
/// [progressCounter] measures the correctly guessed symbols
///
/// [mistakesCounter] is a list of three integers: each of them contains
/// the mistakes made in each of the thirds
/// [totalMistakes] total mistakes made in the whole test
///
/// [symbolsDisplayed] is a list of three integers: each of them contains
///
/// the symbols displayed in each of the thirds
/// [totalDisplayed] total symbols displayed in the whole test
///
/// [thirdsCounter] measures what third the test is currently in:
/// 0 for the first third, 1 for the second, and 2 for the last.
class ProgressProvider extends ChangeNotifier{
  int progressCounter = 0;
  List <int> mistakesCounter = List.filled(3, 0);
  int totalMistakes = 0;
  List <int> symbolsDisplayed = List.filled(3,0);
  int totalDisplayed = 0;
  int thirdsCounter = 0;


  /// Increments by 1 the value of [progressCounter] and calls [notifyListeners]
  void incrementProgressCounter(){
    progressCounter++;
    notifyListeners();
  }

  /// Sets to 0 the [progressCounter] and calls [notifyListeners]
  void resetProgressCounter(){
    progressCounter = 0;
    notifyListeners();
  }


  /// Receives as arguments:
  ///
  /// [elapsedMs] which is the total milliseconds elapsed since the test started
  ///
  /// [limitMs] the duartion of the test in milliseconds.
  ///
  /// With those two values it determines which third is the test in,
  /// gives value to [thirdsCounter] and calls [notifyListeners]
  void updateThirdsCounter(int elapsedMs, int limitMs){
    final newThird = (elapsedMs ~/ (limitMs / 3)).clamp(0,2);
    if (newThird != thirdsCounter) {
      thirdsCounter = newThird;
      notifyListeners();
    }
  }

  /// Sets the [thirdsCounter] to 0 and calls [notifyListeners]
  void resetThirdsCounter(){
    thirdsCounter = 0;
    notifyListeners();
  }

  /// Adds 1 to the [index] element of [mistakesCounter] as well as [totalMistakes]
  /// and calls [notifyListeners]
  void incrementMistakesCounter(int index){
    mistakesCounter[index]++;
    totalMistakes++;
    notifyListeners();
  }

  /// Sets to 0 all the elements of [mistakesCounter] and [totalMistakes]
  /// and calls [notifyListeners]
  void resetMistakesCounter(){
    mistakesCounter = List.filled(3, 0);
    totalMistakes = 0;
    notifyListeners();
  }

  /// Increments by 1 the [index] elements [mistakesCounter] as well as [totalDisplayed]
  /// and calls [notifyListeners]
  void incrementSymbolsDisplayed(int index){
    symbolsDisplayed[index]++;
    totalDisplayed++;
    notifyListeners();
  }

  /// Sets to 0 all elements of [symbolsDisplayed] and [totalDisplayed]
  /// and calls [notifyListeners]
  void resetSymbolsDisplayed(){
    symbolsDisplayed = List.filled(3, 0);
    totalDisplayed = 0;
    notifyListeners();
  }

}

/// This provider handles the data related to the numeric keyboard.
///
/// Its fields are
///
/// [keyPressed] an integer which marks the number of the key that is pressed
///
/// [keyFlag] a boolean that takes the true value if any key has been pressed
class KeyboardProvider extends ChangeNotifier{
  int keyPressed = 0;
  bool keyFlag = false;

  /// Assigns the argument [newKey] to [keyPressed] and calls [notifyListeners]
  void changeKeyPressed({required int newKey}) /*async*/{
    keyPressed = newKey;
    notifyListeners();
  }


  /// Assigns the argument [f] to [keyFlag] and calls [notifyListeners]
  void setFlag(bool f){
    keyFlag = f;
    notifyListeners();
  }
}

/// This provider manages all the time variables in the test. Its fields are:
///
/// [start] time and date the test was started
///
/// [end] time and date the test was finished
///
/// [testTimer] timer used to measure the test timing
///
/// [limitMilliseconds] duration of the test in milliseconds
///
/// [isTestRunning] boolean variable that determines if the test is being taken at the moment
///
/// [startTime] time and date the test was started. It is used for the timer
/// and not for saving test data as [start]
///
/// [partialTimes] list of integers that saves the time taken every by the user
/// to press a key for every symbol displayed
///
/// [isTimeStarted] boolean that determines if the timer has been started in the test
class TimeProvider extends ChangeNotifier{
  DateTime start = DateTime.now();
  DateTime end = DateTime.now();
  Timer? testTimer;
  int limitMilliseconds = 0;
  bool isTestRunning = false;
  late DateTime startTime;
  List <int> partialTimes = [];
  bool isTimeStarted = false;

  /// This getter returns the milliseconds elapsed since the beginning of the test
  int get elapsedMilliseconds => DateTime.now().difference(startTime).inMilliseconds;

  /// This getter returns the milliseconds remaining as a difference between
  /// the duration and the elapsed time
  int get remaining => (limitMilliseconds - elapsedMilliseconds).clamp(0, limitMilliseconds);

  /// Assigns the current time and date to [start] and calls [notifyListeners]
  void setStartTime(){
    start = DateTime.now();
    notifyListeners();
  }

  /// Assigns the current time and date to [end] and calls [notifyListeners]
  void setEndTime(){
    end = DateTime.now();
    notifyListeners();
  }

  /// This function is called to start the timer when the test starts.
  ///
  /// It requires the following arguments:
  ///
  /// [timeLimit] duration of the test in milliseconds
  ///
  /// [onFinish] callback of the function that is to be executed when the time expires
  ///
  /// [pp] the instance of [ProgressProvider] so that the
  /// [ProgressProvider.thirdsCounter] can be updated
  void startTimer({required int timeLimit, required VoidCallback onFinish, required ProgressProvider pp}) {
    debugPrint('Time started');
    testTimer?.cancel();
    startTime = DateTime.now();
    limitMilliseconds=  timeLimit;
    isTestRunning = true;

    //Incrementando a mano los intervalos de tiempo cada 100 ms (elapsed += 100) iba muy lento. Mejor con DateTime.now
    /// Each 100 milliseconds the timer is updated
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

  /// Adds the argument [i] to the [partialTimes] list and calls [notifyListeners]
  void addPartialTime(int i){
    partialTimes.add(i);
  }

  /// Resets [partialTimes] by assigning it an empty list and calls [notifyListeners]
  void resetPartialTimes(){
    partialTimes = [];
  }

  //Aqui se obtienen los tiempos parciales de verdad y se hace la media. No se hace antes por no añadir logica y entorpecer el reloj
  /// Returns the average of the [partialTimes] list
  double getAveragedDuration(){
    for (int i = partialTimes.length - 1; i > 0; i--) {
      partialTimes[i] = partialTimes[i] - partialTimes[i - 1];
    }
    double result = partialTimes.reduce((a, b) => a + b) / partialTimes.length; //Media aritmetica
    return result;
  }

  /// Return the standard deviation of the [partialTimes] list
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

  /// Assigns the argument [b] to [isTimeStarted] and calls [notifyListeners]
  void setIsTimeStarted(bool b){
    isTimeStarted = b;
    notifyListeners();
  }

}

/// This provider is used to handle the smybols displayed in the middle of the screen
///
/// Its fields are:
///
/// [shuffled] a boolean that determines if the symbols list has been shuffled:
/// the order the symbols appear in the reference key must change every time a test
/// (trial or not) starts.
///
/// [symbols] a list with 9 elements: one for each symbol
///
/// [trialCounter] in the trial test all of the 9 symbols have to be displayed
/// (in a random order) before passing to total random mode. This variable is a
/// counter of how many of them have been displayed
///
/// [trialOrder] this list of integers sets the order in which the 9 symbols
/// are to be displayed in the trial test
///
/// [id] the position  in the [symbols] list of the symbol to be displayed
class SymbolsProvider extends ChangeNotifier{
  bool shuffled = false;
  List <String> symbols =  [];
  int trialCounter = 0;
  List <int> trialOrder = [];
  int id = Random().nextInt(9); //Del 0 al 8

  /// Assigns the required argument [newId] to [id] and calls [notifyListeners]
  void changeActiveId({required int newId}) /*async*/ {
    id = newId;
    notifyListeners();
  }

  /// Gives value to [symbols]:
  ///
  /// if [isSymbols1] is true it assigns [GeneralConstants.symbols1]
  ///
  /// if [isSymbols1] is false it assigns [GeneralConstants.symbols2]
  /// Then it and calls [notifyListeners]
  void setSymbols(bool isSymbols1){
    //De esta manera (List<String>.from), se permite modificar la lista
    symbols = List<String>.from(isSymbols1 ? GeneralConstants.symbols1 : GeneralConstants.symbols2);
    notifyListeners();
  }

  //Con esta funcion nos aseguramos que se reordenen los simbolos solo una vez y se queden asi
  /// This function returns the list [symbols].
  /// Before returning the list, it checks the variable [shuffled]
  /// and if it is false, it generates a new random order for the list.
  List <String> getSymbols(){
    if(!shuffled){
      symbols.shuffle(Random());
      shuffled = true;
    }
    return symbols;
  }

  /// Assigns the argument [b] to [shuffled] and calls [notifyListeners]
  void setShuffled(bool b){
    shuffled = b;
    notifyListeners();
  }

  /// Increments by 1 [trialCounter] and calls [notifyListeners]
  void incrementTrialCounter(){
    trialCounter++;
    notifyListeners();
  }

  /// Sets to 0 the [trialCounter] and calls [notifyListeners]
  void resetTrialCounter(){
    trialCounter = 0;
    notifyListeners();
  }

  /// Generates a new random order for a list of numbers from 0 to 8
  /// assigns it to [trialOrder] and calls [notifyListeners]
  void generateNewOrder(){
    trialOrder = List<int>.generate(9, (i) => i)..shuffle(Random());
    print(trialOrder);
    notifyListeners();
  }
}

/// This provider manages a miscellaneous of variables used in the app.
///
/// Its fields are
///
/// [saveButtonPressed] is true when the save button is pressed in the
/// [NewProfileScreen] but one of the fields is not filled or incorrect.
/// It is used to determine when the warning text must display and the
/// fields must be highlighted in red.
///
/// [hand] takes the value 'L' or 'R' depending on the hand
/// chosen by the user to attempt the test
///
/// [codeid] is the reference code
///
/// [codeidController1] is the controller for the part of the reference code
/// before the hyphen
///
/// [codeidController2] is the controller for the part of the reference code
/// after the hyphen
///
/// [dataSent] is a boolean that determines if the test data has been sent
///
/// [dataSentCorrectly] relates to if the test data has been sent successfully
///
/// [isTrialTest] is true when the current test is a trial test
class ParametersProvider extends ChangeNotifier{
  bool saveButtonPressed = false;
  String? hand; //'L' o 'R'
  String? codeid;
  TextEditingController codeidController1 = TextEditingController();
  TextEditingController codeidController2 = TextEditingController();
  bool dataSent = false;
  bool dataSentCorrectly = false;
  bool isTrialTest = true;



  /// Assigns the argument [b] to [isTrialTest] and calls [notifyListeners]
  void setIsTrialTest(bool b){
    isTrialTest = b;
    notifyListeners();
  }


  /// Assigns the argument [c] to [codeid] and calls [notifyListeners]
  void setCodeid(String c){
    codeid = c;
    notifyListeners();
  }



  /// Assigns the argument [d] to [dataSent] and calls [notifyListeners]
  void setDataSent(bool d){
    dataSent = d;
    notifyListeners();
  }

  /// Assigns the argument [d] to [dataSentCorrectly] and calls [notifyListeners]
  void setDataSentCorrectly(bool d){
    dataSentCorrectly = d;
    notifyListeners();
  }


  /// Assigns the argument [h] to [hand] and calls [notifyListeners]
  void setHand (String h){
    hand = h;
    notifyListeners();
  }

  /// Assigns the argument [x] to [saveButtonPressed] and calls [notifyListeners]
  void setSaveButtonPressed(bool x){
    saveButtonPressed = x;
    notifyListeners();
  }

  /// Resets the [codeidController1] by instancing a new [TextEditingController]
  void resetCodeidController1(){
    codeidController1 = TextEditingController();
    notifyListeners();
  }

  /// Resets the [codeidController2] by instancing a new [TextEditingController]
  void resetCodeidController2(){
    codeidController2 = TextEditingController();
    notifyListeners();
  }

}

/// This provider handles all the data related to the profiles.
///
/// Its fields are
///
/// [editingMode] is true when the current profile is been edited
/// and false when a new profile is been created
///
/// [profileCounter] keeps the count of the profiles in the app
///
/// [activeUser] is the position in the list [profilesList] of the currently selected user
///
/// [profilesList] a list with all the profiles in the app
///
/// [tempUser] an instance of [Profile] used to save the data in the [NewProfileScreen]
/// before assigning it to a user in [profilesList]
///
/// [dataController] to handle the birth date selection
///
/// [nicknameController] to handle the nickname textfield
class PersonalDataProvider extends ChangeNotifier{
  bool editingMode = false;
  int profileCounter = 0;
  int? activeUser;
  List<Profile> profilesList = [];
  Profile tempUser = Profile();
  TextEditingController dataController = TextEditingController();
  TextEditingController nicknameController = TextEditingController();
  

  /// Adds the argument [newUser] to [profilesList], increments by 1 the [profileCounter]
  /// and calls [notifyListeners]
  void addNewProfile(Profile newUser){
    profilesList.add(newUser);
    profileCounter++;
    notifyListeners();
  }

  /// Receives a profile [u] and saves it in the [index] position of [profilesList]
  /// and calls [notifyListeners]
  void updateProfile(int index, Profile u){
    profilesList[index] = u;
    notifyListeners();
  }

  /// Assigns the argument [a] to [activeUser] and calls [notifyListeners]
  void setActiveUser(int? a){
    activeUser = a;
    notifyListeners();
  }


  /// Assigns the argument [s] to the [Profile.sex] of [tempUser] and calls [notifyListeners]
  void setTempSex(String s){
    tempUser.sex = s;
    notifyListeners();
  }

  /// Assigns the argument [l] to the [Profile.levelOfStudies] of [tempUser] and calls [notifyListeners]
  void setTempLevelOfStudies (String l){
    tempUser.levelOfStudies = l;
    notifyListeners();
  }

  /// Assigns the argument [n] to the [Profile.nickname] of [tempUser] and calls [notifyListeners]
  void setTempNickname(String n){
    tempUser.nickname = n;
    notifyListeners();
  }

  /// Assigns the argument [b] to the [Profile.isSymbols1] of [tempUser] and calls [notifyListeners]
  void setTempIsSymbols1(bool b){
    tempUser.isSymbols1 = b;
    notifyListeners();
  }

  /// Resets [tempUser] by instancing a new [Profile] and calls [notifyListeners]
  void resetTempUser(){
    tempUser = Profile();
    notifyListeners();
  }

  /// Resets the [profilesList] by assigning it an empty list and calls [notifyListeners]
  void resetProfilesProvider(){
    profilesList = [];
    notifyListeners();
  }

  /// Resets [nicknameController] by instancing a new [TextEditingController]
  /// and calls [notifyListeners]
  void resetNicknameController(){
    nicknameController = TextEditingController();
    notifyListeners();
  }

  /// Resets [dataController] by instancing a new [TextEditingController]
  /// and calls [notifyListeners]
  void resetDataController(){
    dataController = TextEditingController();
    notifyListeners();
  }

  /// Assigns the argument [e] to [editingMode] and calls [notifyListeners]
  void setEditingMode(bool e){
    editingMode = e;
    notifyListeners();
  }


  /// Saves the [profilesList] in SharedPreferences so it can be loaded
  /// after closing the app
  Future<void> saveProfiles() async {
    final prefs = await SharedPreferences.getInstance();

    List<String> profilesJson =
    profilesList.map((profile) => jsonEncode(profile.toJson())).toList();

    await prefs.setStringList('profiles', profilesJson);
    print('Saved: $profilesJson');
    await prefs.setBool('dataExists', true);

  }

  /// Loads the [profilesList] from SharedPreferences. This function is called
  /// every time the app is launched
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

/// This provider manages a series of boolean for the buttons in [HomeScreen]
///
/// Its fields are
///
/// [isUserSelected] is true when a user has been selected
///
/// [isCodeValidated] is true if the reference code has been validated
///
/// [isReadOnly] is true when the reference code text field can not be edited
///
/// [wrongCodeId] is true when the reference code is incorrect
class ButtonsProvider extends ChangeNotifier{
  bool isUserSelected = false;
  bool isCodeValidated = false;
  bool isReadOnly = false;
  bool wrongCodeId = false;

  /// Assigns the argument [w] to [wrongCodeId] and calls [notifyListeners]
  void setWrongCodeid(bool w){
    wrongCodeId = w;
    notifyListeners();
  }


  /// Assigns the argument [i] to [isUserSelected] and calls [notifyListeners]
  void setIsUserSelected(bool i){
    isUserSelected = i;
    notifyListeners();
  }

  /// Assigns the argument [i] to [isReadOnly] and calls [notifyListeners]
  void setIsReadOnly (bool i){
    isReadOnly = i;
    notifyListeners();
  }

  /// Assigns the argument [i] to [isCodeValidated] and calls [notifyListeners]
  void setIsCodeValidated (bool i){
    isCodeValidated = i;
    notifyListeners();
  }

  /// Changes [isUserSelected] to the opposite value of its current one
  /// and calls [notifyListeners]
  void toggleIsUserSelected(){
    isUserSelected = !isUserSelected;
    notifyListeners();
  }

  /// Changes [isCodeValidated] to the opposite value of its current one
  /// and calls [notifyListeners]
  void toggleIsCodeValidated(){
    isCodeValidated = !isCodeValidated;
    notifyListeners();
  }

  /// Changes [isReadOnly] to the opposite value of its current one
  /// and calls [notifyListeners]
  void toggleIsReadOnly(){
    isReadOnly = !isReadOnly;
    notifyListeners();
  }



}

/// This provider handles the data related to the device the app is launched in.
///
/// Its fields are
///
/// [deviceModel] the model of the device
///
/// [diagonalInches] the diagonal of the device measured in inches
class DeviceProvider extends ChangeNotifier{
  String? deviceModel;
  double? diagonalInches;

  /// Assigns the argyment [s] to [deviceModel] and calls [notifyListeners]
  void setDeviceModel(String s){
    deviceModel = s;
    notifyListeners();
  }

  /// Assigns the argyment [d] to [diagonalInches] and calls [notifyListeners]
  void setDiagonalInches(double d){
    diagonalInches = d;
    notifyListeners();
  }



}

