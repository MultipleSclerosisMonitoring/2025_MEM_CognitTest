
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:symbols/utils/HomeButton.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';

import '../utils/AppBar.dart';
import '../utils/homeFunctions.dart';

/// This class returns the [Scaffold] of the new profile screen's UI when its builder is called.
///
/// The [AppBar] is obtained through [getGeneralAppBar].
///
/// The body is organised throguh a main [Column] that has four children:
///
/// The first one is a [Row] with two children:
/// The text "USER: " and the name of the active user, if applies
///
/// The second child is row with three children:
/// The first part of the reference code, the hyphen, and the second part.
/// This row is wrapped in a [Container] to unify the style of the reference code.
/// The third child is a [HomeButton] to create a new profile
///
/// The fourth child is a row with two [HomeButton]: one to view and edit the active profile
/// and one to view the tests completed with that profile
/// The fifth and last child is a [HomeButton] to start the test
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final personalDataProvider = Provider.of<PersonalDataProvider>(context);
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final buttonsProvider = Provider.of<ButtonsProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getGeneralAppBar(context, localeProvider, false),
        body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              // Center is a layout widget. It takes a single child and positions it
              // in the middle of the parent.
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Flexible(
                    child:Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            AppLocalizations.of(context)!.user.toUpperCase() + ":\t",
                            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),

                          DropdownButton2<int?>(
                              hint: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Text(AppLocalizations.of(context)!.value_select,
                                    style: const TextStyle(
                                      //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                        color: Colors.grey,
                                       // fontWeight: parametersProvider.startButtonPressed ? FontWeight.bold : null,
                                        fontSize: 20
                                    ),
                                  ),
                                ),
                              ),
                              style: TextStyle(color: Colors.blue, fontSize: 20),
                              isExpanded: false,
                              underline: SizedBox(),
                              //iconEnabledColor: Colors.blue,
                              value: personalDataProvider.activeUser,
                              items: List.generate(personalDataProvider.profileCounter, (index) {
                                return DropdownMenuItem(
                                  value: index,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(personalDataProvider.profilesList[index].nickname ?? ""),
                                  ),
                                );
                              }).toList(),
                              onChanged: (int? value) {
                                if (value != null) {
                                  personalDataProvider.setActiveUser(value);
                                  buttonsProvider.setIsUserSelected(true);
                                }
                              }
                          ),
                        ],
                      ),
                    ),
                  ),
                        Stack(
                          children: [
                            Center(
                              child: Opacity(
                                opacity: buttonsProvider.isUserSelected ? 1: HomeConstants.opacity,
                                child: Padding(
                                  padding: const EdgeInsets.fromLTRB(16,0,16,8),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: AppColors.primaryBlue,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors.primaryBlue, width: 3),
                                    ),
                                    child: Center(
                                      child: Row(
                                        children: [
                                          Flexible(
                                            flex: 5,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: parametersProvider.codeidController1,
                                                readOnly: buttonsProvider.isReadOnly,
                                                decoration: InputDecoration(
                                                  labelText: AppLocalizations.of(context)!.code_message,
                                                  labelStyle: TextStyle(color: Colors.white,),
                                                  border: const OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                    borderRadius: BorderRadius.circular(HomeConstants.codeIdRadius),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                    borderRadius: BorderRadius.circular(HomeConstants.codeIdRadius),
                                                  ),

                                                ),

                                                style: const TextStyle(color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                          const Flexible(
                                              flex: 1,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                    "-",
                                                    style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold, fontSize: 30),
                                                  ),
                                                ),
                                              )
                                          ),
                                          Flexible(
                                            flex: 2,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: TextField(
                                                controller: parametersProvider.codeidController2,
                                                readOnly: buttonsProvider.isReadOnly,
                                                decoration: InputDecoration(
                                                  border: const OutlineInputBorder(),
                                                  enabledBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                    borderRadius: BorderRadius.circular(HomeConstants.codeIdRadius),
                                                  ),
                                                  focusedBorder: OutlineInputBorder(
                                                    borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                    borderRadius: BorderRadius.circular(HomeConstants.codeIdRadius),
                                                  ),
                                                ),
                                                inputFormatters: [
                                                  FilteringTextInputFormatter.digitsOnly,
                                                  LengthLimitingTextInputFormatter(3),
                                                ],
                                                style: const TextStyle(color: Colors.white,),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            flex: 1,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: IconButton(
                                                icon: buttonsProvider.isReadOnly ?
                                                    const Icon(Icons.edit, color: Colors.white)
                                                    :
                                                    const Icon(Icons.check, color: Colors.white),
                                                onPressed:  () => codeIdButton(context),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if(!buttonsProvider.isUserSelected) const Center(child: Icon(Icons.lock, size: HomeConstants.lockSize, color: Colors.red)),
                          ],
                        ),

                  Expanded(
                    child: HomeButton(
                      text: AppLocalizations.of(context)!.profile_creation,
                      onPressed: () => createProfile(context),
                      height: screenHeight / HomeConstants.buttonHeightRatio,
                      isActive: true,
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: HomeButton(
                            text: AppLocalizations.of(context)!.view_profile,
                            onPressed: () => editProfile(context),
                            height: screenHeight / HomeConstants.buttonHeightRatio,
                            isActive: buttonsProvider.isUserSelected,
                          )
                        ),
                        Expanded(
                            child: HomeButton(
                                text: AppLocalizations.of(context)!.view_tests,
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) =>
                                        AlertDialog(
                                          title: Text(
                                            //Se comprueba si la lista existe y está llena. En el caso de no existir, no evalua el testList!.isNotEmpty
                                            ((personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList != null) &&
                                            (personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList!.isNotEmpty)) ?
                                            AppLocalizations.of(context)!.my_tests : AppLocalizations.of(context)!.no_tests ,
                                            style: const TextStyle(
                                                fontWeight: FontWeight
                                                    .bold,
                                                color: Colors.red),
                                          ),
                                          content:
                                          ((personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList != null) &&
                                              (personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList!.isNotEmpty)) ?
                                              //Aqui empieza el contenido si existe y no esta vacia la lista de tests
                                          Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                children: [
                                                  Expanded(child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        AppLocalizations.of(context)!.date,
                                                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blueText),
                                                    ),
                                                  )),
                                                  Expanded(child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        AppLocalizations.of(context)!.hand,
                                                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blueText),
                                                    ),
                                                  )),
                                                  Expanded(child: FittedBox(
                                                    fit: BoxFit.scaleDown,
                                                    child: Text(
                                                        '${AppLocalizations.of(context)!.answers} / ${AppLocalizations.of(context)!.mistakes}',
                                                        style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.blueText),
                                                    ),
                                                  )),
                                                ],
                                              ),
                                              Row(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Columna de fechas
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList!.map((d) => FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          '${d.date!.day}/${d.date!.month}/${(d.date!.year)%100} | ${d.date!.hour}:${d.date!.minute.toString().padLeft(2,'0')}',
                                                          style: const TextStyle(fontSize: HomeConstants.viewMyTestsFont),
                                                        ),
                                                      )).toList(),
                                                    ),
                                                  ),

                                                  // Columna de nombres
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList!.map((d) => FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          (d.hand == "L") ? AppLocalizations.of(context)!.l : AppLocalizations.of(context)!.r,
                                                          style: const TextStyle(fontSize: HomeConstants.viewMyTestsFont),
                                                        ),
                                                      )).toList(),
                                                    ),
                                                  ),

                                                  // Columna de valores
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.center,
                                                      children: personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0].testList!.map((d) => FittedBox(
                                                        fit: BoxFit.scaleDown,
                                                        child: Text(
                                                          '${d.displayed} / ${d.mistakes}',
                                                          style: const TextStyle(fontSize: HomeConstants.viewMyTestsFont),
                                                        ),
                                                      )).toList(),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )
                                          //Aqui acaba el contenido si la lista de test existe y no esta vacia
                                            :
                                            Text(""),
                                          actions: [
                                            TextButton(
                                              onPressed: () => Navigator.of(context).pop(),
                                              child: const Text('OK',
                                                  style: TextStyle(fontSize: 20)),
                                            ),
                                          ],
                                        ),
                                  );
                                },
                                height: screenHeight / HomeConstants.buttonHeightRatio,
                                isActive: buttonsProvider.isUserSelected
                            )
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: HomeButton(
                        text: AppLocalizations.of(context)!.start,
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) =>
                                AlertDialog(
                                  title: Text(
                                    AppLocalizations.of(context)!.trial_title,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.blueText),
                                  ),
                                  content: SingleChildScrollView(
                                    child: Text(
                                      AppLocalizations.of(context)!.test_explanation,
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: AppColors.blueText),
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                      child: Text(AppLocalizations.of(context)!.back,
                                          style: const TextStyle(
                                              fontSize: 20)),
                                    ),
                                    TextButton(
                                      onPressed: () => startTest(context),
                                      child: Text(AppLocalizations.of(context)!.start_trial,
                                          style: TextStyle(
                                              fontSize: 20)),
                                    ),
                                  ],
                                ),
                          );
                        },
                        height: screenHeight / HomeConstants.buttonHeightRatio,
                        isActive: buttonsProvider.isCodeValidated,
                    ),
                  ),

                ],
              ),
            ),
          ),
      ),
    );
  }
}

