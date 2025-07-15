import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';

class NewProfileScreen extends StatelessWidget {
  const NewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final personalDataProvider = Provider.of<PersonalDataProvider>(context);
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final buttonsProvider = Provider.of<ButtonsProvider>(context);
    final Profile tempUser = personalDataProvider.tempUser;
    TextEditingController dateController = personalDataProvider.dataController;
    TextEditingController nicknameController = personalDataProvider.nicknameController;



    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          toolbarHeight: MediaQuery.of(context).size.height / GeneralConstants.toolbarHeightRatio,
          backgroundColor: Colors.white,
          //leading: Image.asset('assets/images/saludmadrid.jpg'),
          actions:[ Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
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
                        icon: const Padding(
                          padding:  EdgeInsets.all(8.0),
                          child:  Icon(Icons.language, color: Colors.white),
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
          padding: const EdgeInsets.all(2.0),
          child: Center(
            // Center is a layout widget. It takes a single child and positions it
            // in the middle of the parent.
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //mainAxisSize: MainAxisSize.min,
              children: [

                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.nickname.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Flexible(
                                  child: TextField(
                                    style: TextStyle(color: AppColors.blueText),
                                    onChanged: (value) => personalDataProvider.setTempNickname(value),
                                    controller: nicknameController,
                                    decoration: InputDecoration(
                                      hintText: parametersProvider.editingMode ? tempUser.nickname : AppLocalizations.of(context)!.nickname,
                                      hintStyle: TextStyle(color: parametersProvider.editingMode ? AppColors.blueText : (parametersProvider.saveButtonPressed ? Colors.red : Colors.black)),
                                      border: const OutlineInputBorder(),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.indigo, width: 3),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(color: Colors.indigo, width: 3),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.birth_message.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.indigo, width: 3),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal:8),
                                      child: TextField(
                                        controller: dateController,
                                        readOnly: true,
                                        style: TextStyle(color: AppColors.blueText),
                                        decoration: InputDecoration(
                                          hintText: parametersProvider.editingMode ? "${tempUser.dateOfBirth!.day}/${tempUser.dateOfBirth!.month}/${tempUser.dateOfBirth!.year}" : "DD/MM/YYYY",
                                          hintStyle: TextStyle(color: parametersProvider.editingMode ? AppColors.blueText : (parametersProvider.saveButtonPressed ? Colors.red : Colors.black)),
                                          labelStyle: TextStyle(color: (parametersProvider.saveButtonPressed && tempUser.dateOfBirth == null) ? Colors.red : Colors.black),
                                          suffixIcon: Icon(Icons.calendar_today),
                                       ),
                                        onTap: () async {
                                          FocusScope.of(context).requestFocus(FocusNode()); // Cierra el teclado si está abierto
                                          final DateTime? picked = await showDatePicker(
                                            context: context,
                                            initialDate: tempUser.dateOfBirth ?? DateTime(2000),
                                            firstDate: DateTime(1900),
                                            lastDate: DateTime.now(),
                                            locale: localeProvider.locale, // Para idioma español
                                          );
                                          if (picked != null) {
                                            tempUser.dateOfBirth = picked;
                                            dateController.text = "${picked.day}/${picked.month}/${picked.year}";
                                          }
                                        },
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of(context)!.education_message.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.indigo, width: 3),
                            ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: AppColors().getBlueText(), width: 1),
                                      ),
                                      child: DropdownButton<String>(
                                        hint: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(AppLocalizations.of(context)!.value_select,
                                            style: TextStyle(
                                              //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                              color: parametersProvider.saveButtonPressed ? Colors.red : Colors.black,
                                              fontWeight: parametersProvider.saveButtonPressed ? FontWeight.bold : null,
                                            ),
                                          ),
                                        ),
                                        underline: SizedBox(),
                                        style: TextStyle(color: AppColors.blueText),
                                        iconEnabledColor: AppColors().getBlueText(),
                                        value: tempUser.levelOfStudies,
                                        onChanged: (newValue) {
                                          if (newValue != null) {
                                            personalDataProvider.setTempLevelOfStudies(newValue);
                                          }
                                        },
                                        items: [
                                          DropdownMenuItem<String>(
                                            value: '1',
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!.primary),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: '2',
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!.secondary),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'G',
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!.degree),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'M',
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                  AppLocalizations.of(context)!.master),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'D',
                                            child:
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(AppLocalizations.of(context)!.phd),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Text(
                                  AppLocalizations.of(context)!.sex_message.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.indigo, width: 3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors().getBlueText(), width: 1),
                                    ),
                                      child: DropdownButton<String>(
                                          hint: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(AppLocalizations.of(context)!.value_select,
                                              style: TextStyle(
                                                //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                                color: parametersProvider.saveButtonPressed ? Colors.red : Colors.black,
                                                fontWeight: parametersProvider.saveButtonPressed ? FontWeight.bold : null,
                                              ),
                                            ),
                                          ),
                                          underline: SizedBox(),
                                          style: TextStyle(color: AppColors.blueText),
                                          iconEnabledColor: Colors.blue,
                                          value: tempUser.sex,
                                          items: [
                                            DropdownMenuItem<String>(
                                              value: 'M',
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(AppLocalizations.of(context)!.male),
                                              ),
                                            ),
                                            DropdownMenuItem<String>(
                                              value: 'F',
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(
                                                    AppLocalizations.of(context)!.female),
                                              ),
                                            ),
                                          ],
                                          onChanged: (String? value) {
                                            if (value != null) {
                                              personalDataProvider.setTempSex(value);
                                            }
                                          }),
                                    ),
                                  ),
                                ],
                      
                              ),
                            ),
                          ),

                          Padding(
                            padding: const EdgeInsets.fromLTRB(16.0, 30.0, 16.0 ,4.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children:[
                                Text(
                                  AppLocalizations.of(context)!.symbols.toUpperCase(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.indigo, width: 3),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(4.0),
                                    child: Container(decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: AppColors().getBlueText(), width: 1),
                                    ),
                                      child: DropdownButton<bool>(
                                          hint: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: Text(AppLocalizations.of(context)!.value_select,
                                              style: TextStyle(
                                                //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                                color: parametersProvider.saveButtonPressed ? Colors.red : Colors.black,
                                                fontWeight: parametersProvider.saveButtonPressed ? FontWeight.bold : null,
                                              ),
                                            ),
                                          ),
                                          underline: SizedBox(),
                                          style: TextStyle(color: AppColors.blueText),
                                          iconEnabledColor: Colors.blue,
                                          value: tempUser.isSymbols1,
                                          items: const[
                                            DropdownMenuItem<bool>(
                                              value: true,
                                              child:
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(GeneralConstants.symbols1String),
                                              ),
                                            ),
                                            DropdownMenuItem<bool>(
                                              value: false,
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Text(GeneralConstants.symbols2String ),
                                              ),
                                            ),
                                          ],
                                          onChanged: (bool? value) {
                                            if (value != null) {
                                              personalDataProvider.setTempIsSymbols1(value);
                                            }
                                          }),
                                    ),
                                  ),
                                ],

                              ),
                            ),
                          ),
                      


                    if (parametersProvider.editingMode)  Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0 ,4.0),
                      child: ElevatedButton(
                        onPressed: () { showDialog(
                          context: context,
                          builder: (context) =>
                              AlertDialog(
                                content: Text(
                                  AppLocalizations.of(
                                      context)!.delete_message,
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: AppColors()
                                          .getBlueText()),
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
                                    onPressed: () async {
                                      personalDataProvider.profilesList.removeAt(personalDataProvider.activeUser ?? 0);
                                      personalDataProvider.profileCounter--;
                                      buttonsProvider.setIsUserSelected(false);
                                      personalDataProvider.setActiveUser(null); //Para que no se cuelgue testParametersScreen al volver
                                      await personalDataProvider.saveProfiles();
                                      Navigator.pushNamed(context, '/');
                                      personalDataProvider.resetTempUser();
                                    },
                                    child: Text('OK',
                                        style: TextStyle(
                                            fontSize: 20)),
                                  ),
                                ],
                              ),
                        );
                          }
                          ,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context)!.delete_profile,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0 ,4.0),
                      child: ElevatedButton(
                        onPressed: () async {
                          if( tempUser.dateOfBirth != null &&
                              tempUser.sex != null &&
                              tempUser.levelOfStudies != null &&
                              tempUser.nickname != "" &&
                              tempUser.isSymbols1 != null
                          ) {
                              parametersProvider.setSaveButtonPressed(false);
                              if (parametersProvider.editingMode) {
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
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: AppColors()
                                                    .getBlueText()),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.of(context).pop(),
                                              child: Text('OK',
                                                  style: TextStyle(
                                                      fontSize: 20)),
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

                          } else{
                            parametersProvider.setSaveButtonPressed(true);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            AppLocalizations.of(context)!.save_profile,
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(30.0),
                      child: Text(
                        parametersProvider.saveButtonPressed ? AppLocalizations.of(context)!.data_error : "",
                        style: TextStyle(
                          color: Colors.red,
                        ),
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
        ),
      ),
    );
  }
}
