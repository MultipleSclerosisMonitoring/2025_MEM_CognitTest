
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:symbols/utils/testFunctions.dart';

import '../l10n/generated/l10n.dart';
import 'constants.dart';

void startTest(BuildContext context){
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
  final symbolsProvider = Provider.of<SymbolsProvider>(context, listen: false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);

    Navigator.pushNamed(context, '/countdownScreen', arguments: (){
      timeProvider.setIsTimeStarted(false);
      parametersProvider.setIsTrialTest(true);
      progressProvider.resetThirdsCounter();
      parametersProvider.setSaveButtonPressed(false);
      symbolsProvider.setSymbols(personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].isSymbols1 ?? true);
      symbolsProvider.generateNewOrder();
      symbolsProvider.resetTrialCounter();
      timeProvider.resetPartialTimes();
      timeProvider.startTimer(timeLimit: GeneralConstants.trialDuration, onFinish: () => finishTrialTest(context), pp: progressProvider);
      Navigator.pushNamed(context, '/testScreen');
    });
}

void createProfile(BuildContext context){
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);

  personalDataProvider.setEditingMode(false);
  personalDataProvider.resetNicknameController();
  personalDataProvider.resetDataController();
  personalDataProvider.resetTempUser();
  parametersProvider.setSaveButtonPressed(false);
  Navigator.pushNamed(context, '/newProfileScreen');
}

void editProfile(BuildContext context){
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);

  personalDataProvider.tempUser = personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0];
  personalDataProvider.setEditingMode(true);
  Navigator.pushNamed(context, '/newProfileScreen');
}

void codeIdButton(context) async {
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final buttonsProvider = Provider.of<ButtonsProvider>(context, listen: false);

  if(!buttonsProvider.isReadOnly) {
    parametersProvider.setCodeid(
        (parametersProvider.codeidController1.text) + '-' + (parametersProvider.codeidController2.text)
    );
    print(parametersProvider
        .codeid);
    final int answer = await checkCodeid(
        codeid: parametersProvider
            .codeid ?? 'c');
    switch (answer) {
      case 2: //Codigo erroneo
        wrongCodeId(buttonsProvider, context);
        break;
      case 3: //Codigo ya utilizado
        usedCodeId(buttonsProvider, context);
        break;
      case 1: //Codigo correcto y no usado
        correctCodeId(buttonsProvider);
        break;
      default:
        buttonsProvider.setIsReadOnly(false);
        break;
    }
  } else{
    buttonsProvider.setIsReadOnly(false);
  }
}

void wrongCodeId(ButtonsProvider bp, BuildContext context){
  bp.setIsCodeValidated(false);
  bp.setWrongCodeid(true);
  bp.setIsReadOnly(false);
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.error_title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
          content: Text(
            AppLocalizations.of(context)!.error_text,
            style: const TextStyle(
                fontSize: 20,
                color: AppColors.blueText
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(),
              child: const Text('OK',
                  style: TextStyle(
                      fontSize: 20)
              ),
            ),
          ],
        ),
  );
}

void usedCodeId(ButtonsProvider bp, BuildContext context){
  bp.setIsCodeValidated(false);
  bp.setWrongCodeid(true);
  bp.setIsReadOnly(false);
  showDialog(
    context: context,
    builder: (context) =>
        AlertDialog(
          title: Text(
            AppLocalizations.of(context)!.error_title,
            style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.red),
          ),
          content: Text(
            AppLocalizations.of(context)!.code_used,
            style: const TextStyle(
                fontSize: 20,
                color: AppColors.blueText
            ),
          ),
          actions: [
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(),
              child: const Text('OK',
                  style: TextStyle(
                      fontSize: 20)
              ),
            ),
          ],
        ),
  );
}

void correctCodeId(ButtonsProvider bp){
  bp.setWrongCodeid(false);
  bp.setIsCodeValidated(true);
  bp.setIsReadOnly(true);
}

void saveProfile(BuildContext context) async {
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);
  final tempUser = personalDataProvider.tempUser;

  if (tempUser.dateOfBirth != null &&
      tempUser.sex != null &&
      tempUser.levelOfStudies != null &&
      tempUser.nickname != "" &&
      tempUser.isSymbols1 != null
  ) {
    parametersProvider.setSaveButtonPressed(false);
    if (personalDataProvider.editingMode) {
      personalDataProvider.updateProfile(
          personalDataProvider.activeUser ?? 0, tempUser);
    }
    else {
      bool nicknameRepeated = false;
      for (int i = 0; i <
          personalDataProvider.profilesList
              .length; i++) {
        if (tempUser.nickname ==
            personalDataProvider.profilesList[i]
                .nickname) {
          nicknameRepeated = true;
        }
      }
      if (nicknameRepeated) {
        showDialog(
          context: context,
          builder: (context) =>
              AlertDialog(
                content: Text(
                  AppLocalizations.of(context)!
                      .nickname_used,
                  style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.blueText
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.of(context).pop(),
                    child: const Text('OK',
                        style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
        );
      } else {
        personalDataProvider.addNewProfile(tempUser);
        personalDataProvider.resetTempUser();
      }
    }
    await personalDataProvider.saveProfiles();
    Navigator.pushNamed(context, '/');
  } else {
    parametersProvider.setSaveButtonPressed(true);
  }
}

void deleteProfile(BuildContext context) async {
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);
  final buttonsProvider = Provider.of<ButtonsProvider>(context, listen: false);

  personalDataProvider.profilesList.removeAt(personalDataProvider.activeUser ?? 0);
  personalDataProvider.profileCounter--;
  buttonsProvider.setIsUserSelected(false);
  personalDataProvider.setActiveUser(null); //Para que no se cuelgue testParametersScreen al volver
  await personalDataProvider.saveProfiles();
  Navigator.pushNamed(context, '/');
  personalDataProvider.resetTempUser();
}