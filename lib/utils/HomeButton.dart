import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:symbols/utils/constants.dart';

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
            borderRadius: BorderRadius.circular(HomeConstants.buttonRadius),
          ),
          child: Opacity(
            opacity: isActive ? 1 : HomeConstants.opacity,
            child: Padding(
              padding: const EdgeInsets.all(HomeConstants.buttonPadding),
              child: SizedBox(
                height: height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(HomeConstants.buttonRadius),
                  child: Material(
                    color: AppColors.secondaryBlue,
                    child: InkWell(
                      splashColor: Colors.indigo,
                      highlightColor: Colors.indigo[200],
                      onTap: isActive ? onPressed : null,
                      child: Padding(
                        padding: const EdgeInsets.all(HomeConstants.buttonTextPadding),
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
                                      fontSize: constraints.maxHeight * HomeConstants.buttonTextHeightRatio),
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
       if(!isActive) Center(child: Icon(Icons.lock, size: HomeConstants.lockSize, color: Colors.red)),
      ]
    );
  }
}