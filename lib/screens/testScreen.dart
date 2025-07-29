
import 'package:flutter/material.dart';
import 'package:symbols/utils/AppBar.dart';
import 'package:symbols/utils/constants.dart';
import 'package:symbols/utils/numberKey.dart';
import 'package:symbols/state_management/providers.dart';
import 'package:provider/provider.dart';
import 'package:symbols/utils/testFunctions.dart';

/// This class returns the [Scaffold] of the test screen's UI when its builder is called
/// The UI is organised as follows:
///
/// The appbar is obtained from [getTestAppBar]
///
/// The body is first structured with a main [Column] that divides the screen in 10 [Row].
/// The sum of the flex factors of every row is 17, so each row occupies a vertical portion of the screen of
/// its flex factor divided by 17.
///
/// The first six rows, each with a flex factor of 1, form the reference key:
///
/// First row hosts symbols 1 to 3, and second row symbols 1 to 3.
///
/// Third row hosts symbols 4 to 6, and fourth row symbols 4 to 6.
///
/// Fifth row hosts symbols 7 to 9, and sixth row symbols 7 to 9.
///
/// The reference key occupies, as explained before, 6/17 of the height body of the screen.
///
/// The seventh row is for the central symbol and has a flex factor of 5.
///
/// The remaining three rows are for the numeric keyboard, each of them having a flex factor of 2.
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
