import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';


// Widget para los símbolos
Widget buildSymbol(String symbol) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      symbol,
      style: const TextStyle(fontSize: 30),
    ),
  );
}

// Widget para los números
Widget buildNumber(int number) {
  return FittedBox(
    fit: BoxFit.scaleDown,
    child: Text(
      '$number',
      style: const TextStyle(fontSize: 30),
    ),
  );
}

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

    context.read<IdProvider>().changeActiveId(newId: newRandom(activeId, parametersProvider.isTrialTest, symbolsProvider.trialCounter, symbolsProvider.trialOrder)); //Generamos nuevo simbolo
    if(parametersProvider.isTrialTest) {
      symbolsProvider.incrementTrialCounter();
    }
    progressProvider.incrementSymbolsDisplayed(progressProvider.thirdsCounter);
    debugPrint('total: ' + '${progressProvider.totalDisplayed}');
  }


}

void testCallback(BuildContext context, int activeId, int activeKey){
  //Si empezamos el tiempo en countdownScreen, en testScreen sale ya empezado
  final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final symbolsProvider = Provider.of<SymbolsProvider>(context, listen: false);
  if (parametersProvider.isTimeStarted == false) {
    parametersProvider.setIsTimeStarted(true);
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
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: AppColors().getBlueText()),
          ),
          content: Text(AppLocalizations.of(
              context)!.trial_completed,
            style: TextStyle(
                fontSize: 20,
                color: AppColors().getBlueText()),
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
                  parametersProvider.setIsTimeStarted(false);
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
                  parametersProvider.setIsTimeStarted(false);
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
    device: deviceProvider.deviceModel ?? 'unknownDevice',
    diagInch: deviceProvider.diagonalInches.toString(),
  );
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

