import 'package:flutter/material.dart';

import '../theme.dart';

class SpecialButton extends StatelessWidget{
  final VoidCallback onPressed;
  final List<Widget> children;
  final Color? backGroundColor;

  const SpecialButton({
  super.key,
  required this.onPressed,
  required this.children,
  this.backGroundColor,
  });

  @override
  Widget build(BuildContext context) =>
      ElevatedButton(

          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  )
              ),
              elevation: MaterialStateProperty.all(5),
              backgroundColor: MaterialStateProperty.all(backGroundColor??ThemeColors.PRIMARY_LIGHT)
          ),
          onPressed:()=>onPressed(),
          child:
          Padding(padding: EdgeInsets.all(7),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: children
            ),)
      );

}