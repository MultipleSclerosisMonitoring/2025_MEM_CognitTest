import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:symbols/constants.dart';
import 'package:symbols/providers.dart';

class NumberKey extends StatelessWidget{
  final int number;
  final double height;

  const NumberKey({
    Key? key,
    required this.number,
    required this.height,
  }) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Stack(
        children:[
          Card(
              elevation: 0,
              color: Colors.black,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  color: Colors.black,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SizedBox(
                  height: height,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Material(
                          color: AppColors.secondaryBlue,
                          child: InkWell(
                            splashColor: Colors.indigo,
                            highlightColor: Colors.indigo[200],
                            // onTap: isActive ? onPressed : null,
                            onTap: () {
                              context.read<KeyboardProvider>().changeKeyPressed(newKey: number);
                              context.read<KeyboardProvider>().setFlag(true);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                  child: Text(
                                    "$number",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(color: AppColors.blueText, fontWeight: FontWeight.bold, fontSize: 30),
                                  )
                              ),
                            ),

                          )
                      )
                  )
              )
          ),
        ]
    );
  }
}