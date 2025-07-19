
import 'package:flutter/material.dart';
import 'package:symbols/utils/AppBar.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/utils/numberKey.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/utils/testFunctions.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int activeKey = context.watch<KeyboardProvider>().keyPressed;
    final symbolsProvider = Provider.of<SymbolsProvider>(context);
    int activeId = symbolsProvider.id;
    double screenHeight = MediaQuery.of(context).size.height;
    List <String> symbols = symbolsProvider.getSymbols();
    final remaining =  context.watch<TimeProvider>().isTimeStarted ? context.watch<TimeProvider>().remaining : 90000;
    final minutes = (remaining ~/ 60000).toString().padLeft(2, '0');
    final seconds = ((remaining % 60000) ~/ 1000).toString().padLeft(2, '0');


    //Callback para que la funcion se ejecute una vez se ha terminado el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      testCallback(context, activeId, activeKey);
    });

    return Scaffold(
      appBar: getTestAppBar(context, minutes, seconds),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyHorizontalPadding),
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
                      style: const TextStyle(fontSize: TestConstants.centralSymbolSize)
                  ),
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyboardHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 1, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 2, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 3, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                  ],
                ),
              ),
            ),
            // Números
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyboardHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 4, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 5, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 6, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: TestConstants.keyboardHorizontalPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: NumberKey(number: 7, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 8, height: screenHeight / TestConstants.numberKeyHeightRatio)),
                    Expanded(
                        child: NumberKey(number: 9, height: screenHeight / TestConstants.numberKeyHeightRatio)),
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
