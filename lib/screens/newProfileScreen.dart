import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/state_management/locale_provider.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/l10n/generated/l10n.dart';

import '../utils/AppBar.dart';
import '../utils/homeFunctions.dart';
import '../utils/profile.dart';

class NewProfileScreen extends StatelessWidget {
  const NewProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final personalDataProvider = Provider.of<PersonalDataProvider>(context);
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final Profile tempUser = personalDataProvider.tempUser;
    TextEditingController dateController = personalDataProvider.dataController;
    TextEditingController nicknameController = personalDataProvider.nicknameController;



    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: getGeneralAppBar(context, localeProvider, true),
        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Padding(
                  padding: NewProfileConstants().generalPadding,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: NewProfileConstants().titlePadding,
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
                          padding: NewProfileConstants().fieldPadding,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Flexible(
                                child: TextField(
                                  style: const TextStyle(color: AppColors.blueText),
                                  onChanged: (value) => personalDataProvider.setTempNickname(value),
                                  controller: nicknameController,
                                  decoration: InputDecoration(
                                    hintText: personalDataProvider.editingMode ? tempUser.nickname : AppLocalizations.of(context)!.nickname,
                                    hintStyle: TextStyle(color: personalDataProvider.editingMode ? AppColors.blueText : (parametersProvider.saveButtonPressed ? Colors.red : Colors.black)),
                                    border: const OutlineInputBorder(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                                      borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                                      borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: NewProfileConstants().titlePadding,
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
                          padding: NewProfileConstants().fieldPadding,
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                              borderRadius: BorderRadius.circular(NewProfileConstants.radius),
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
                                        hintText: personalDataProvider.editingMode ? "${tempUser.dateOfBirth!.day}/${tempUser.dateOfBirth!.month}/${tempUser.dateOfBirth!.year}" : "DD/MM/YYYY",
                                        hintStyle: TextStyle(color: personalDataProvider.editingMode ? AppColors.blueText : (parametersProvider.saveButtonPressed ? Colors.red : Colors.black)),
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
                          padding: NewProfileConstants().titlePadding,
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
                          padding: NewProfileConstants().fieldPadding,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                              border: Border.all(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                          ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: NewProfileConstants().innerPadding,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                                      border: Border.all(color: AppColors.blueText, width: NewProfileConstants.dropdownWidth)
                                    ),
                                    child: DropdownButton<String>(
                                      hint: Padding(
                                        padding: NewProfileConstants().innerPadding,
                                        child: Text(AppLocalizations.of(context)!.value_select,
                                          style: TextStyle(
                                            //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                            color: parametersProvider.saveButtonPressed ? Colors.red : Colors.black,
                                            fontWeight: parametersProvider.saveButtonPressed ? FontWeight.bold : null,
                                          ),
                                        ),
                                      ),
                                      underline: const SizedBox(),
                                      style: const TextStyle(color: AppColors.blueText),
                                      iconEnabledColor: AppColors.blueText,
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
                                            padding: NewProfileConstants().dropdownPadding,
                                            child: Text(
                                                AppLocalizations.of(context)!.primary),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: '2',
                                          child: Padding(
                                            padding: NewProfileConstants().dropdownPadding,
                                            child: Text(
                                                AppLocalizations.of(context)!.secondary),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'G',
                                          child: Padding(
                                            padding: NewProfileConstants().dropdownPadding,
                                            child: Text(
                                                AppLocalizations.of(context)!.degree),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'M',
                                          child: Padding(
                                            padding: NewProfileConstants().dropdownPadding,
                                            child: Text(
                                                AppLocalizations.of(context)!.master),
                                          ),
                                        ),
                                        DropdownMenuItem<String>(
                                          value: 'D',
                                          child:
                                          Padding(
                                            padding: NewProfileConstants().dropdownPadding,
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
                          padding: NewProfileConstants().titlePadding,
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
                          padding: NewProfileConstants().fieldPadding,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                              border: Border.all(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: NewProfileConstants().innerPadding,
                                  child: Container(decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                                    border: Border.all(color: AppColors.blueText, width: NewProfileConstants.dropdownWidth),
                                  ),
                                    child: DropdownButton<String>(
                                        hint: Padding(
                                          padding: NewProfileConstants().innerPadding,
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
                                              padding: NewProfileConstants().dropdownPadding,
                                              child: Text(AppLocalizations.of(context)!.male),
                                            ),
                                          ),
                                          DropdownMenuItem<String>(
                                            value: 'F',
                                            child: Padding(
                                              padding: NewProfileConstants().dropdownPadding,
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
                          padding: NewProfileConstants().titlePadding,
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
                          padding: NewProfileConstants().fieldPadding,
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                              border: Border.all(color: Colors.indigo, width: NewProfileConstants.boxWidth),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: NewProfileConstants().innerPadding,
                                  child: Container(decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(NewProfileConstants.radius),
                                    border: Border.all(color: AppColors.blueText, width: NewProfileConstants.dropdownWidth),
                                  ),
                                    child: DropdownButton<bool>(
                                        hint: Padding(
                                          padding: NewProfileConstants().innerPadding,
                                          child: Text(AppLocalizations.of(context)!.value_select,
                                            style: TextStyle(
                                              //Si se ha intentado iniciar el test sin rellenar este campo, el texto sale en rojo y negrita
                                              color: parametersProvider.saveButtonPressed ? Colors.red : Colors.black,
                                              fontWeight: parametersProvider.saveButtonPressed ? FontWeight.bold : null,
                                            ),
                                          ),
                                        ),
                                        underline: const SizedBox(),
                                        style: const TextStyle(color: AppColors.blueText),
                                        iconEnabledColor: Colors.blue,
                                        value: tempUser.isSymbols1,
                                        items: [
                                          DropdownMenuItem<bool>(
                                            value: true,
                                            child:
                                            Padding(
                                              padding: NewProfileConstants().dropdownPadding,
                                              child: const Text(GeneralConstants.symbols1String),
                                            ),
                                          ),
                                          DropdownMenuItem<bool>(
                                            value: false,
                                            child: Padding(
                                              padding: NewProfileConstants().dropdownPadding,
                                              child: const Text(GeneralConstants.symbols2String ),
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



                  if (personalDataProvider.editingMode)  Padding(
                    padding: NewProfileConstants().buttonsPadding,
                    child: ElevatedButton(
                      onPressed: () { showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              content: Text(
                                AppLocalizations.of(
                                    context)!.delete_message,
                                style: const TextStyle(
                                    fontSize: 20,
                                    color: AppColors.blueText
                                ),
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(),
                                  child: Text(AppLocalizations.of(context)!.back,
                                      style: const TextStyle(fontSize: 20)),
                                ),
                                TextButton(
                                  onPressed: () => codeIdButton(context),
                                  child: const Text('OK',
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
                        padding: NewProfileConstants().buttonsTextPadding,
                        child: Text(
                          AppLocalizations.of(context)!.delete_profile,
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: NewProfileConstants().buttonsPadding,
                    child: ElevatedButton(
                      onPressed: () => saveProfile(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                      ),
                      child: Padding(
                        padding: NewProfileConstants().buttonsTextPadding,
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
    );
  }
}
