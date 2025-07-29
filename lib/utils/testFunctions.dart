import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:symbols/screens/countdownScreen.dart';
import 'package:symbols/screens/resultsScreen.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';
import 'package:symbols/utils/test.dart';


/// This function returns a widget that displays the [symbol] passed as an argument.
/// It is used to create the symbols in the reference key
Widget buildSymbol(String symbol) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      symbol,
      style: const TextStyle(fontSize: 30),
    ),
  );
}

/// This function returns a widget that displays the [number] passed as an argument.
/// It is used to create the numbers in the reference key
Widget buildNumber(int number) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      '$number',
      style: const TextStyle(fontSize: 30),
    ),
  );
}

/// Generates a new random number from 0 to 8, to determine which of the
/// symbols in the symbol list is going to display in the middle of the screen.
///
/// In the trial test, first all the nine symbols are displayed once each,
/// and then switches to complete random mode.
///
/// The arguments are:
///
/// [currentId] is the number of the symbol that is on the screen at the moment.
///
/// [isTrial] is a boolean that is true if the running test is the trial.
///
/// [counter] counts the number of symbols that have been displayed in the middle
/// since the start of the test, only in the trial test.
///
/// [order] is a list of integers that determines the sequence of the first nine
/// symbols that are to be displayed in the middle.
///
/// First the code checks if it is trial test and not less than nine symbols have
/// been displayed. If so, it shows the corresponding symbol in the sequence.
/// IF it is not trial or the nine symbols have already been showed, it generates
/// a new random symbol with the only condition of being different from the current one.
int newRandom(int currentId, bool isTrial, int counter, List<int> order) {
  if(isTrial && counter < 9){
    return order[counter];
  }
  else {
    final random = Random();
    int randomNumber;
    do {
      randomNumber = random.nextInt(9);
    } while (randomNumber ==
        currentId); //Nos aseguramos de que cambie el simbolo
    return randomNumber;
  }
}

//Funcion que comprueba si se ha presionado una tecla y si es correcta
/// This function is the foundation of the logic behind the test.
/// When called, it checks if any key has been pressed and if so
/// it executes the corresponding instructions.
///
/// Its arguments are:
///
/// [activeId], which is the integer of the symbol currently in the middle of the screen
///
/// [activeKey], which is the number of the last key pressed
///
/// [context] to access the providers
///
/// First it checks the [KeyboardProvider.keyFlag] to see if a key has been pressed.
/// If true, it sets the flag to false and adds the current time to
/// [TimeProvider.partialTimes]. Then it checks if the key pressed is the
/// correct one or not, and adds one to the [ProgressProvider.progressCounter]
/// which counts the correct symbols, or to the [ProgressProvider.mistakesCounter].
/// After that, calls [SymbolsProvider.changeActiveId] to update the central symbol
/// and if it is the trial test increments the [SymbolsProvider.trialCounter].
/// It also increments the [ProgressProvider.symbolsDisplayed].
///
/// The providers are instanced with listen:false because the function is outside the widget tree
/// and it does not need to react to changes in the providers.
void checkSuccessAndUpdate(BuildContext context,
    int activeId,
    int activeKey) async{
  final progressProvider = Provider.of<ProgressProvider>(context, listen:false);
  final keyboardProvider = Provider.of<KeyboardProvider>(context, listen: false);
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final symbolsProvider = Provider.of<SymbolsProvider>(context, listen: false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);


  // Comprobar si se ha presionado el teclado
  if (keyboardProvider.keyFlag) {
    keyboardProvider.setFlag(false);
    timeProvider.addPartialTime(timeProvider.elapsedMilliseconds);
    //Verificar si la tecla presionada coincide con el símbolo activo
    if (activeId == (activeKey - 1)) {
      progressProvider.incrementProgressCounter();
      debugPrint('score: ' + '${progressProvider.progressCounter}');
    }
    else{ //Sumamos los errores
      progressProvider.incrementMistakesCounter(progressProvider.thirdsCounter);
      debugPrint('mistakes: ' + '${progressProvider.totalMistakes}');
    }

    symbolsProvider.changeActiveId(newId: newRandom(activeId, parametersProvider.isTrialTest, symbolsProvider.trialCounter, symbolsProvider.trialOrder)); //Generamos nuevo simbolo
    if(parametersProvider.isTrialTest) {
      symbolsProvider.incrementTrialCounter();
    }
    progressProvider.incrementSymbolsDisplayed(progressProvider.thirdsCounter);
    debugPrint('total: ' + '${progressProvider.totalDisplayed}');
  }


}

/// This function is called every time the test screen widget is reconstructed
///
/// Its arguments are [context], [activeId] and [activeKey].
///
/// First it checks if the test time has been started [TimeProvider.isTimeStarted]
/// If it has not, it sets the test start time [TimeProvider.setStartTime]
/// and starts the test timer [TimeProvider.startTimer]
/// Then calls [checkSuccessAndUpdate] for the test logic.
/// The providers are instanced with listen:false because the function is outside the widget tree
/// and it does not need to react to changes in the providers.
void testCallback(BuildContext context, int activeId, int activeKey){
  //Si empezamos el tiempo en countdownScreen, en testScreen sale ya empezado
  final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final symbolsProvider = Provider.of<SymbolsProvider>(context, listen: false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);
  if (timeProvider.isTimeStarted == false) {
    timeProvider.setIsTimeStarted(true);
    symbolsProvider.setShuffled(false);
    if (parametersProvider.isTrialTest) {
      context.read<TimeProvider>().setStartTime();
      context.read<TimeProvider>().startTimer(
          timeLimit: GeneralConstants.trialDuration,
          onFinish: () => finishTrialTest(context),
          pp: progressProvider);
    }
    else if (parametersProvider.isTrialTest == false) {
      context.read<TimeProvider>().setStartTime();
      context.read<TimeProvider>().startTimer(
          timeLimit: GeneralConstants.testDuration,
          onFinish: () => finishTest(context),
          pp: progressProvider);
    }
  }
  checkSuccessAndUpdate(context, activeId, activeKey);
}


/// This function is executed when the trial test is finished
///
/// First it displays an emerging screen where the user selects
/// which hand the test will be attempted with,
/// giving value to [ParametersProvider.hand]. Then the following
/// test variables are reset:
/// [ProgressProvider.mistakesCounter], [ProgressProvider.progressCounter]
/// [ProgressProvider.thirdsCounter], [ProgressProvider.symbolsDisplayed]
/// and [TimeProvider.partialTimes]
/// Then it pushes the [CountdownScreen], passing as arguments the
/// functions to execute after the countdown:
/// [TimeProvider.setIsTimeStarted], [ParametersProvider.setIsTrialTest]
/// and pushing the [TestScreen]
///
/// The only argument is the [context] to access the providers.
/// The providers are instanced with listen:false because the function is outside the widget tree
/// and it does not need to react to changes in the providers.
void finishTrialTest(BuildContext context){
  final progressProvider = Provider.of<ProgressProvider>(context, listen:false);
  final parametersProvider = Provider.of<ParametersProvider>(context, listen:false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) =>
        AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.well_done,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors.blueText
            ),
          ),
          content: Text(AppLocalizations.of(
              context)!.trial_completed,
            style: const TextStyle(
                fontSize: 20,
                color: AppColors.blueText
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                parametersProvider.setHand('L');
                progressProvider.resetThirdsCounter();
                progressProvider.resetMistakesCounter();
                progressProvider.resetProgressCounter();
                progressProvider.resetSymbolsDisplayed();
                timeProvider.resetPartialTimes();
                parametersProvider.setDataSent(false);
                Navigator.pushNamed(context, '/countdownScreen', arguments: (){
                  timeProvider.setIsTimeStarted(false);
                  parametersProvider.setIsTrialTest(false);
                  Navigator.pushNamed(context, '/testScreen');
                });
              },
              child: Text(AppLocalizations.of(context)!.left,
                  style: TextStyle(
                      fontSize: 20)),
            ),
            TextButton(
              onPressed: () {
                parametersProvider.setHand('R');
                progressProvider.resetThirdsCounter();
                progressProvider.resetMistakesCounter();
                progressProvider.resetProgressCounter();
                progressProvider.resetSymbolsDisplayed();
                timeProvider.resetPartialTimes();
                parametersProvider.setDataSent(false);
                Navigator.pushNamed(context, '/countdownScreen', arguments: (){
                  timeProvider.setIsTimeStarted(false);
                  parametersProvider.setIsTrialTest(false);
                  Navigator.pushNamed(context, '/testScreen');
                });
              },
              child: Text(AppLocalizations.of(context)!.right,
                  style: const TextStyle(
                      fontSize: 20)),
            ),
          ],
        ),
  );
}

/// This function is called when the official test is finished.
///
/// First it calls [TimeProvider.getAveragedDuration] and [TimeProvider.getStdDeviation]
/// to calculate the average and standard deviation of all the partial times.
/// Then it calls [Profile.addTest] to add the completed test to the active
/// user's test list.
///
/// After that it sends the information to the backend by calling
/// [enviarDatosSDMT]. Based on the API feedback, it sets the value
/// of [ParametersProvider.dataSentCorrectly] to true or false.
///
/// To finish, it resets all the control variables involved in the test
/// and some of the home screen too, like the text controllers.
/// Waits half a second and pushes to the [ResultsScreen]
///
/// The only argument is the [context] to access the providers.
/// The providers are instanced with listen:false because the function is outside the widget tree
/// and it does not need to react to changes in the providers.
void finishTest(BuildContext context) async{
  context.read<TimeProvider>().setEndTime();
  final progressProvider = Provider.of<ProgressProvider>(context, listen:false);
  final parametersProvider = Provider.of<ParametersProvider>(context, listen:false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen:false);
  final deviceProvider = Provider.of<DeviceProvider>(context, listen:false);
  final buttonsProvider = Provider.of<ButtonsProvider>(context, listen: false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);

  parametersProvider.setDataSent(true);
  final double averagedDuration= timeProvider.getAveragedDuration();
  final double sdev_duration = timeProvider.getStdDeviation();
  personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].addTest(Test(date: DateTime.now(), hand: parametersProvider.hand, displayed: progressProvider.totalDisplayed, mistakes: progressProvider.totalMistakes));
  final sset = (personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].isSymbols1 == true) ? "set1" : "set2";
  final int answer = await enviarDatosSDMT(
    codeid: parametersProvider.codeid ?? "",
    fNacimiento: personalDataProvider.profilesList[personalDataProvider.activeUser ?? -1].dateOfBirth?.toIso8601String().substring(0,10) ?? "",
    sexo: personalDataProvider.profilesList[personalDataProvider.activeUser ?? -1].sex ?? "",
    nivelEduc: personalDataProvider.profilesList[personalDataProvider.activeUser ?? -1].sex ?? "",
    mano: parametersProvider.hand ?? "",
    numSim: progressProvider.totalDisplayed.toString(),
    tiempo: "90",
    errores: progressProvider.totalMistakes.toString(),
    score: progressProvider.progressCounter.toString(),
    num_Dig_1: progressProvider.symbolsDisplayed[0].toString(),
    num_Dig_2: progressProvider.symbolsDisplayed[1].toString(),
    num_Dig_3: progressProvider.symbolsDisplayed[2].toString(),
    number_Errors: progressProvider.totalMistakes.toString(),
    number_Errors_1: progressProvider.mistakesCounter[0].toString(),
    number_Errors_2: progressProvider.mistakesCounter[1].toString(),
    number_Errors_3: progressProvider.mistakesCounter[2].toString(),
    averaged_duration: averagedDuration.toString(),
    sdev_duration: sdev_duration.toString(),
    symbol_set:sset,
    device: deviceProvider.deviceModel ?? 'unknownDevice',
    diagInch: deviceProvider.diagonalInches.toString(),
  );
  debugPrint('sending info');
  if(answer == -1){
    parametersProvider.setDataSentCorrectly(false);
  } else{
    parametersProvider.setDataSentCorrectly(true);
  }
  progressProvider.resetThirdsCounter();
  progressProvider.resetMistakesCounter();
  progressProvider.resetProgressCounter();
  progressProvider.resetSymbolsDisplayed();
  parametersProvider.setDataSent(false);
  personalDataProvider.saveProfiles();
  parametersProvider.resetCodeidController1();
  parametersProvider.resetCodeidController2();
  parametersProvider.setIsTrialTest(true);
  timeProvider.resetPartialTimes();
  buttonsProvider.setIsCodeValidated(false);
  buttonsProvider.setIsReadOnly(false);

  Future.delayed(const Duration(milliseconds: 500),(){
    Navigator.pushNamed(context, '/resultsScreen');
  });
}

/// This function receives the String [codeid] and sends it to the
/// procesarSDMT service in the API to check if it is valid. It returns an integer:
///
/// -1 if there was a mistake connecting with the API
///
/// 1 if the code is valid and has never been used
///
/// 2 if the code is not valid
///
/// 3 if the code is valid but has already been used
Future<int> checkCodeid ({required String codeid}) async {
  final url = Uri.parse('http://apii01.etsii.upm.es/AppCognit/procesarSDMT');

  final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {
        'codeid': codeid,
      }
  );

  if (response.statusCode == 200) {
    print('Datos enviados Correctamente: ${response.body}');
    final data = jsonDecode(response.body);
    if(data['message'] == 'OK'){
      if(data['exists'] == 0) {
        return 1;
      } else{
        final List<dynamic> handsUsed = data['hands'];
        if(handsUsed.isNotEmpty){
          return 3;
        } else {
          return 1;
        }
      }
    }
    else {
      return 2;
    }
  }
  print('Error al Enviar datos: ${response.statusCode}');
  return -1;



}
// Devuelve 1 si el codeid es correcto, 2 si es incorrecto
// 3 si ya se ha usado
// y -1 si no se han enviado correctamente


/// This function is called to send the test and profile data to the server
/// through the reportarSDMT service.
/// Its arguments are all the strings sent through the API:
/// [codeid] the reference code
///
/// [fNacimiento] birth date
///
/// [sexo] sex
///
/// [nivelEduc] level of finsihed studies
///
/// [mano] hand used to attempt the test
///
/// [numSim] total number of symbols displayed
///
/// [tiempo] duration of the test
///
/// [score] total number of symbols guessed correctly
///
/// [number_Errors] total number of mistakes
///
/// [num_Dig_1] symbols displayed in the first third (1 to 30 seconds)
///
/// [num_Dig_2] symbols displayed in the second third (31 to 60 seconds)
///
/// [num_Dig_3] symbols displayed in the last third (61 to 90 seconds)
///
/// [number_Errors_1] mistakes in the first third (1 to 30 seconds)
///
/// [number_Errors_2] mistakes in the second third (31 to 60 seconds)
///
/// [number_Errors_3] mistakes in the last third (61 to 90 seconds)
///
/// [averaged_duration] average time taken to press a number in the keyboard
///
/// [sdev_duration] standard deviation of the times taken to press a number
///
/// [symbol_set] 1 or 2 depending on the set of symbols displayed
///
/// [device] model of the device used for the test
///
/// [diagInch] diagonal of the device measured in inches
///
/// The function returns an integer:
///
/// -1 if it was not able to connect the server
///
/// 1 if the data was sent correctly
///
/// 2 if it connected the server but there was a mistake in the data sending
Future<int> enviarDatosSDMT({
  required String codeid,
  required String fNacimiento,
  required String sexo,
  required String nivelEduc,
  required String mano,
  required String numSim,
  required String tiempo,
  required String errores,
  required String score,
  required String number_Errors,
  required String num_Dig_1,
  required String num_Dig_2,
  required String num_Dig_3,
  required String number_Errors_1,
  required String number_Errors_2,
  required String number_Errors_3,
  required String averaged_duration,
  required String sdev_duration,
  required String symbol_set,
  required String device,
  required String diagInch
}) async {
  final url = Uri.parse('http://apii01.etsii.upm.es/AppCognit/reportarSDMT');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/x-www-form-urlencoded',
    },
    body: {
      'codeid': codeid,
      'F_nacimiento': fNacimiento,
      'Sexo': sexo,
      'Nivel_Educ': nivelEduc,
      'Mano': mano,
      'NumSim': numSim,
      'Time_complete': tiempo,
      'Number_Errors': number_Errors,
      'Score': score,
      'Num_Dig_1': num_Dig_1,
      'Num_Dig_2': num_Dig_2,
      'Num_Dig_3': num_Dig_3,
      'Number_Errors_1': number_Errors_1,
      'Number_Errors_2': number_Errors_2,
      'Number_Errors_3': number_Errors_3,
      'Averaged_Duration': averaged_duration,
      'Sdev_Duration': sdev_duration,
      'Device': device,
      'DiagInch': diagInch,
      'Symbol_Set': symbol_set,
    },
  );

  if (response.statusCode == 200) {
    print('Datos enviados Correctamente: ${response.body}');
    final data = jsonDecode(response.body);
    if(data['message'] == 'OK'){
      return 1;
    } else{
      return 2;
    }
  } else {
    print('Error al Enviar datos: ${response.statusCode}' + '');
    return -1;
  }
}

