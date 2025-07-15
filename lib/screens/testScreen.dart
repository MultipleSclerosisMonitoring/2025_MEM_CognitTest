
import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/utils/numberKey.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/utils/testFunctions.dart';

class CognitionTestScreen extends StatelessWidget {
  const CognitionTestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int activeId = context
        .watch<IdProvider>()
        .id;
    int activeKey = context
        .watch<KeyboardProvider>()
        .keyPressed;
    final parametersProvider = Provider.of<ParametersProvider>(context);
    final symbolsProvider = Provider.of<SymbolsProvider>(context);
    final progressProvider = Provider.of<ProgressProvider>(context);
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    List <String> symbols = symbolsProvider.getSymbols();
    final remaining = context
        .watch<TimeProvider>()
        .remaining;
    final minutes = (remaining ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((remaining % 60000) ~/ 1000).toString().padLeft(2, '0');


    //Callback para que la funcion se ejecute una vez se ha terminado el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      //Si empezamos el tiempo en countdownScreen, en testScreen sale ya empezado
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
    });

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery
            .of(context)
            .size
            .height / GeneralConstants.toolbarHeightRatio,
        backgroundColor: Colors.white,
        //leading: Image.asset('assets/images/saludmadrid.jpg'),
        actions: [ Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('$minutes:$seconds',
                        style: TextStyle(
                            color: AppColors().getBlueText(),
                            fontSize: 30
                        )),
                  ],
                ),
              ),
            ],
          ),
        ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSymbol(symbols[0]),
                    buildSymbol(symbols[1]),
                    buildSymbol(symbols[2]),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNumber(1),
                    buildNumber(2),
                    buildNumber(3),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSymbol(symbols[3]),
                    buildSymbol(symbols[4]),
                    buildSymbol(symbols[5]),
                  ],
                ),
              ),
            ),

            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNumber(4),
                    buildNumber(5),
                    buildNumber(6),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildSymbol(symbols[6]),
                    buildSymbol(symbols[7]),
                    buildSymbol(symbols[8]),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    buildNumber(7),
                    buildNumber(8),
                    buildNumber(9),
                  ],
                ),
              ),
            ),
            // Símbolos y números

            // Números


            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(symbols[activeId],
                      style: const TextStyle(fontSize: 130)
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 1, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 2, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 3, height: screenHeight / 12)),
                  ],
                ),
              ),
            ),
            // Números
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 4, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 5, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 6, height: screenHeight / 12)),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 7, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 8, height: screenHeight / 12)),
                    Expanded(
                        child: NumberKey(number: 9, height: screenHeight / 12)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
