import 'dart:math';
import 'package:flutter/material.dart';
import 'providers.dart';
import 'package:provider/provider.dart';

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
    bool isKeyPressed = context
        .watch<KeyboardProvider>()
        .keyFlag;

    List <String> symbols = context.watch<SymbolsProvider>().getSymbols();

    //Callback para que la funcion se ejecute una vez se ha terminado el build
    WidgetsBinding.instance.addPostFrameCallback((_) {
      checkSuccessAndUpdate(context, activeId, activeKey, isKeyPressed);
    });

    return Scaffold(
      appBar: AppBar(
        title: Text('Cognition Test '),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          // Símbolos y números
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Símbolos
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSymbol(symbols[0]),
                    _buildSymbol(symbols[1]),
                    _buildSymbol(symbols[2]),
                    _buildSymbol(symbols[3]),
                    _buildSymbol(symbols[4]),
                    _buildSymbol(symbols[5]),
                    _buildSymbol(symbols[6]),
                    _buildSymbol(symbols[7]),
                    _buildSymbol(symbols[8]),
                  ],
                ),
                // Números
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildNumber(1),
                    _buildNumber(2),
                    _buildNumber(3),
                    _buildNumber(4),
                    _buildNumber(5),
                    _buildNumber(6),
                    _buildNumber(7),
                    _buildNumber(8),
                    _buildNumber(9),
                  ],
                ),
              ],
            ),
          ),
          // Símbolo central
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child:
              Text(symbols[activeId - 1],
                  style: TextStyle(fontSize: 150)
              ),
            ),
          ),
          // Botones numéricos


          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                // Símbolos
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildKey(context, 1),
                    _buildKey(context, 2),
                    _buildKey(context, 3),
                  ],
                ),
                // Números
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildKey(context, 4),
                    _buildKey(context, 5),
                    _buildKey(context, 6),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildKey(context, 7),
                    _buildKey(context, 8),
                    _buildKey(context, 9),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  // Widget para los símbolos
  Widget _buildSymbol(String symbol) {
    return Text(
      symbol,
      style: const TextStyle(fontSize: 24),
    );
  }

  // Widget para los números
  Widget _buildNumber(int number) {
    return Text(
      '$number',
      style: const TextStyle(fontSize: 18),
    );
  }


  Widget _buildKey(BuildContext context, int number) {
    return ElevatedButton(
      onPressed: () {
        context.read<KeyboardProvider>().changeKeyPressed(newKey: number);
        context.read<KeyboardProvider>().toggleFlag();
      },
      style: ElevatedButton.styleFrom(
        textStyle: const TextStyle(fontSize: 24),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
      child: Text('$number'),
    );
  }

  int newRandom(int currentId) {
    final random = Random();
    int randomNumber;
    do{
    randomNumber = random.nextInt(9) + 1;
    } while(randomNumber == currentId); //Nos aseguramos de que cambie el simbolo
    return randomNumber;
  }

//Funcion que comprueba si se ha presionado una tecla y si es correcta
  void checkSuccessAndUpdate(BuildContext context,
      int activeId,
      int activeKey,
      bool isKeyPressed,) {


    // Comprobar si se ha presionado el teclado
    if (isKeyPressed) {
      context.read<KeyboardProvider>().toggleFlag();

      //Verificar si la tecla presionada coincide con el símbolo activo
      if (activeId == activeKey) {
        final progressProvider = context.read<ProgressProvider>();
        context.read<TimeProvider>().setPartialTime(progressProvider.progressCounter);
        progressProvider.incrementProgressCounter();
        if(progressProvider.progressCounter > 29){
          context.read<TimeProvider>().setEndTime();
        } else {
          context.read<IdProvider>().changeActiveId(
              newId: newRandom(activeId)); //Generamos nuevo simbolo
        }
      }
      else{ //Sumamos los errores
        final progressProvider = context.read<ProgressProvider>();
        progressProvider.incrementMistakesCounter(progressProvider.progressCounter);
      }
    }


  }
}