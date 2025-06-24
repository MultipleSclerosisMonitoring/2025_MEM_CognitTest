import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:symbols/constants.dart';

class HomeButton extends StatelessWidget{
  final String text;
  final VoidCallback? onPressed;
  final bool isActive;
  final double height;

  const HomeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.height,
    this.isActive = true,
  }) : super(key:key);

  @override
  Widget build(BuildContext context){
    return Stack(
      children:[
        Card(
          elevation: 0,
          color: AppColors.secondaryBlueClear,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Opacity(
            opacity: isActive ? 1 : 0.2,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SizedBox(
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Material(
                    color: AppColors.secondaryBlue,
                    child: InkWell(
                      splashColor: Colors.indigo,
                      highlightColor: Colors.indigo[200],
                     // onTap: isActive ? onPressed : null,
                      onTap: isActive ? onPressed : null,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(

                            child: LayoutBuilder(
                              builder: (context, constraints) {
                                return Text(
                                  text,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(color: AppColors.blueText,
                                      fontWeight: FontWeight.bold,
                                      fontSize: constraints.maxHeight*0.3),
                                );
                              }
                            ),
                        ),
                      ),

                    )
                  )
                )
              ),
            )
          )
        ),
       if(!isActive) Center(child: Icon(Icons.lock, size: 40, color: Colors.red)),
      ]
    );
  }
}