
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:symbols/utils/HomeButton.dart';
import 'package:symbols/screens/testScreen.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final personalDataProvider = Provider.of<PersonalDataProvider>(context);
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final symbolsProvider = Provider.of<SymbolsProvider>(context);
    final buttonsProvider = Provider.of<ButtonsProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    final timeProvider = Provider.of<TimeProvider>(context);
    double screenHeight = MediaQuery.of(context).size.height;


    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: screenHeight / GeneralConstants.toolbarHeightRatio,
          backgroundColor: Colors.white,
          //leading: Image.asset('assets/images/saludmadrid.jpg'),
          actions:[ Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Image.asset('assets/images/saludMadridPng.png'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Image.asset('assets/images/upm.png'),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.red,
                      child: DropdownButton<Locale>(
                        value: localeProvider.locale,
                        icon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: const Icon(Icons.language, color: Colors.white),
                        ),
                        dropdownColor: Colors.red,
                        onChanged: (Locale? newLocale) {
                          if (newLocale != null) {
                            localeProvider.setLocale(newLocale);
                          }
                        },
                        items: const [
                          DropdownMenuItem(
                            value: Locale('en'),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('🇺🇸',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          DropdownMenuItem(
                            value: Locale('es'),
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text('🇪🇸',
                                  style: TextStyle(color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
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
                                  style: TextStyle(
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
                              opacity: buttonsProvider.isUserSelected ? 1: 0.2,
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
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                  borderRadius: BorderRadius.circular(7),
                                                ),

                                              ),

                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
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
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                                focusedBorder: OutlineInputBorder(
                                                  borderSide: BorderSide(color: buttonsProvider.wrongCodeId ? Colors.red : Colors.white,),
                                                  borderRadius: BorderRadius.circular(7),
                                                ),
                                              ),
                                              inputFormatters: [
                                                FilteringTextInputFormatter.digitsOnly,
                                                LengthLimitingTextInputFormatter(3),
                                              ],
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Flexible(
                                          flex: 1,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: IconButton(
                                              icon: buttonsProvider.isReadOnly ?
                                                  Icon(Icons.edit, color: Colors.white)
                                                  :
                                                  Icon(Icons.check, color: Colors.white),
                                              onPressed: () async{
                                                if(!buttonsProvider.isReadOnly) {
                                                  parametersProvider.setCodeid(
                                                      (parametersProvider.codeidController1.text) + '-' +
                                                      (parametersProvider.codeidController2.text)
                                                  );
                                                  print(parametersProvider
                                                      .codeid);
                                                  final int answer = await checkCodeid(
                                                      codeid: parametersProvider
                                                          .codeid ?? 'c');
                                                  switch (answer) {
                                                    case 2: //Codigo erroneo
                                                        buttonsProvider.setIsCodeValidated(false);
                                                        buttonsProvider.setWrongCodeid(true);
                                                        buttonsProvider.setIsReadOnly(false);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                  AppLocalizations.of(context)!.error_title,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),
                                                                ),
                                                                content: Text(
                                                                  AppLocalizations.of(context)!.error_text,
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: AppColors().getBlueText()),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context).pop(),
                                                                    child: Text('OK',
                                                                        style: TextStyle(
                                                                            fontSize: 20)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                        );
                                                        break;
                                                    case 3: //Codigo ya utilizado
                                                        buttonsProvider.setIsCodeValidated(false);
                                                        buttonsProvider.setWrongCodeid(true);
                                                        buttonsProvider.setIsReadOnly(false);
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                title: Text(
                                                                  AppLocalizations.of(context)!.error_title,
                                                                  style: TextStyle(
                                                                      fontWeight: FontWeight.bold,
                                                                      color: Colors.red),
                                                                ),
                                                                content: Text(
                                                                  AppLocalizations.of(context)!.code_used,
                                                                  style: TextStyle(
                                                                      fontSize: 20,
                                                                      color: AppColors().getBlueText()),
                                                                ),
                                                                actions: [
                                                                  TextButton(
                                                                    onPressed: () =>
                                                                        Navigator.of(context).pop(),
                                                                    child: Text('OK',
                                                                        style: TextStyle(
                                                                            fontSize: 20)
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                        );
                                                        break;
                                                    case 1: //Codigo correcto y no usado
                                                      buttonsProvider.setWrongCodeid(false);
                                                      buttonsProvider.setIsCodeValidated(true);
                                                      buttonsProvider.setIsReadOnly(true);
                                                      break;
                                                    default:
                                                        buttonsProvider.setIsReadOnly(false);
                                                        break;
                                                  }
                                                } else{
                                                  buttonsProvider.setIsReadOnly(false);
                                                }
                                              },
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
                          if(!buttonsProvider.isUserSelected) Center(child: Icon(Icons.lock, size: 40, color: Colors.red)),
                        ],
                      ),



                Expanded(
                  child: HomeButton(
                    text: AppLocalizations.of(context)!.profile_creation,
                    onPressed: () {
                      parametersProvider.setEditingMode(false);
                      personalDataProvider.resetNicknameController();
                      personalDataProvider.resetDataController();
                      personalDataProvider.resetTempUser();
                      parametersProvider.setSaveButtonPressed(false);
                      Navigator.pushNamed(context, '/newProfileScreen');
                    },
                    height: screenHeight / 7,
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
                          onPressed: () {
                            personalDataProvider.tempUser = personalDataProvider.profilesList[personalDataProvider.activeUser ?? 0];
                            parametersProvider.setEditingMode(true);
                            Navigator.pushNamed(context, '/newProfileScreen');
                          },
                          height: screenHeight / 7,
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
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors().getBlueText()),
                                                  ),
                                                )),
                                                Expanded(child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      AppLocalizations.of(context)!.hand,
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors().getBlueText()),
                                                  ),
                                                )),
                                                Expanded(child: FittedBox(
                                                  fit: BoxFit.scaleDown,
                                                  child: Text(
                                                      '${AppLocalizations.of(context)!.answers} / ${AppLocalizations.of(context)!.mistakes}',
                                                      style: TextStyle(fontWeight: FontWeight.bold, color: AppColors().getBlueText()),
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
                                                        style: TextStyle(fontSize: 16),
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
                                                        style: TextStyle(fontSize: 16),
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
                                                        style: TextStyle(fontSize: 16),
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
                                            child: Text('OK',
                                                style: TextStyle(
                                                    fontSize: 20)),
                                          ),
                                        ],
                                      ),
                                );
                              },
                              height: screenHeight / 7,
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
                                  AppLocalizations.of(
                                      context)!.trial_title,
                                  style: TextStyle(
                                      fontWeight: FontWeight
                                          .bold,
                                      color: AppColors().getBlueText()),
                                ),
                                content: SingleChildScrollView(
                                  child: Text(
                                    AppLocalizations.of(
                                        context)!.test_explanation,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: AppColors()
                                            .getBlueText()),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context)
                                            .pop(),
                                    child: Text(AppLocalizations.of(context)!.back,
                                        style: TextStyle(
                                            fontSize: 20)),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushNamed(context, '/countdownScreen', arguments: (){
                                        parametersProvider.setIsTimeStarted(false);
                                        parametersProvider.setIsTrialTest(true);
                                        progressProvider.resetThirdsCounter();
                                        parametersProvider.setSaveButtonPressed(false);
                                        symbolsProvider.generateNewOrder();
                                        symbolsProvider.resetTrialCounter();
                                        timeProvider.resetPartialTimes();
                                        timeProvider.startTimer(timeLimit: GeneralConstants.trialDuration, onFinish: () => finishTrialTest(context), pp: progressProvider);
                                        Navigator.pushNamed(context, '/testScreen');
                                      });
                                    },
                                    child: Text(AppLocalizations.of(context)!.start_trial,
                                        style: TextStyle(
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                        );
                      },
                      height: screenHeight / 7,
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

