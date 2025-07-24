
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:symbols/screens/countdownScreen.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:symbols/utils/testFunctions.dart';

import '../l10n/generated/l10n.dart';
import 'constants.dart';

/// This function is called when the trial test is to be started.
/// The only argument is the [context] so that the function can access the providers.
/// When the function is executed, it navigates to the [CountdownScreen], to whom it passes
/// a series of instructions to execute when the countdown finishes.
/// These instructions reset a series of control variables, shuffle the symbols, start the timer
/// and pops the [TestScreen].
///
/// The providers are instanced with listen:false because the function is outside the widget tree
/// and it does not need to react to changes in th providers.

void startTest(BuildContext context){
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final progressProvider = Provider.of<ProgressProvider>(context, listen: false);
  final symbolsProvider = Provider.of<SymbolsProvider>(context, listen: false);
  final timeProvider = Provider.of<TimeProvider>(context, listen: false);
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);

    Navigator.pushNamed(context, '/countdownScreen', arguments: (){
      /// So the test screen knows it has to start the timer
      timeProvider.setIsTimeStarted(false);
      /// This functions starts the TRIAL test
      parametersProvider.setIsTrialTest(true);
      progressProvider.resetThirdsCounter();
      parametersProvider.setSaveButtonPressed(false);
      /// Generates the set of symbols the user selected in the profile
      symbolsProvider.setSymbols(personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].isSymbols1 ?? true);
      /// Generate sequence so all symbols display during trial
      symbolsProvider.generateNewOrder();
      symbolsProvider.resetTrialCounter();
      timeProvider.resetPartialTimes();
      Navigator.pushNamed(context, '/testScreen');
    });
}

/// This function is executed when the "Create a new profile" button is pressed
/// Its only argument is [context] in order to access the providers.
/// The function sets [PersonalDataProvider.editingMode] to false and resets the text controllers and [PersonalDataProvider.tempUser]
/// before navigating to the new profile screen
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

/// This function is executed when the "View my profile" button is pressed
/// Its only argument is [context] in order to access the providers.
/// The function sets [PersonalDataProvider.editingMode] to true and assigns the active user to [PersonalDataProvider.tempUser]
/// before navigating to the new profile screen
void editProfile(BuildContext context){
  final personalDataProvider = Provider.of<PersonalDataProvider>(context, listen: false);

  personalDataProvider.tempUser = personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0];
  personalDataProvider.setEditingMode(true);
  Navigator.pushNamed(context, '/newProfileScreen');
}

/// This function is triggered when the button next to the reference code text field is pressed
/// This button is used to edit the code (when in read only mode)
/// or to validate the code (when not in read only mode) using [checkCodeId].
/// Depending on the result that the check returns, one of the following functions is called:
/// [correctCodeId], [wrongCodeId], [usedCodeId]
/// The only argument is [context] to access the providers
///
void codeIdButton(context) async {
  final parametersProvider = Provider.of<ParametersProvider>(context, listen: false);
  final buttonsProvider = Provider.of<ButtonsProvider>(context, listen: false);

  if(!buttonsProvider.isReadOnly) {
    parametersProvider.setCodeid(
        (parametersProvider.codeidController1.text) + '-' + (parametersProvider.codeidController2.text)
    );
    print(parametersProvider.codeid);
    final int answer = await checkCodeid(
        codeid: parametersProvider.codeid ?? 'c');
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

/// This function is called when the validated reference code is not valid.
///
/// It sets the value of the control variables
/// [ButtonsProvider.wrongCodeId], [ButtonsProvider.isCodeValidated] and [ButtonsProvider.isReadOnly]
/// and displays an error message.
/// The user must click OK on the screen to close the error message.
///
/// The arguments are [bp],which is the [ButtonsProvider] that hosts the control variables
/// and the [context].
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

/// This function is called when the reference code is correct but has already been used.
///
/// It sets the value of the control variables
/// [ButtonsProvider.wrongCodeId], [ButtonsProvider.isCodeValidated] and [ButtonsProvider.isReadOnly]
/// and displays an error message.
/// The user must click OK on the screen to close the error message.
///
/// The arguments are [bp], which is the [ButtonsProvider] that hosts the control variables
/// and the [context].
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

/// This function is called when the reference code validated is valid and has not been used.
///
/// It sets the value of the control variables
/// [ButtonsProvider.wrongCodeId], [ButtonsProvider.isCodeValidated] and [ButtonsProvider.isReadOnly]
///
/// The only argument is [bp], an instance of [ButtonsProvider] that hosts the control variables
void correctCodeId(ButtonsProvider bp){
  bp.setWrongCodeid(false);
  bp.setIsCodeValidated(true);
  bp.setIsReadOnly(true);
}

/// This function is called when the save button is pressed in the new profile screen.
///
/// The only argument is the [context] so that the function can access the providers.
///
/// The function first checks if all the fields are filled in:
/// if they are not, the unfilled fields appear in red.
/// If they are filled, it checks if [PersonalDataProvider.editingMode] is true.
/// If it is, the function calls [PersonalDataProvider.updateProfile].
/// If it is not, the function checks if there is another profile with the same nickname:
/// if there is one, a message is displayed and the user must enter a different nickname.
/// If the nickname is not repeated, [PersonalDataProvider.addNewProfile] is called.
///
/// Regardless of updating or adding a new profile, [PersonalDataProvider.saveProfiles] is called to
/// save the profiles on SharedPreferences
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
      /// Loop to check if the nickname is already taken
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

/// When in editing mode, this function is called to delete the active user.
///
/// It removes the [PersonalDataProvider.activeUser] element
/// of the list [PersonalDataProvider.profilesList], and updates the
/// [PersonalDataProvider.profileCounter]. Then saves the profiles list
/// in shared preferences and goes back to the home page
///
/// The only argument is [context] to access the providers
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