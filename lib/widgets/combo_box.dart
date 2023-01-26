import 'package:flutter/material.dart';

import '../theme.dart';
import 'line.dart';

class ComboBox extends StatelessWidget{
  final String label;
  final String text;
  final int? tag;
  final Function(int) onTap;
  final IconData? data;
  final Color? textColor;

  const ComboBox({
    super.key,
    required this.label,
    required this.text,
    this.tag,
    required this.onTap,
  this.data, this.textColor
  });

  @override
  Widget build(BuildContext context) =>
      Container(padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
          height: 70,
          child:Column(
              children: [
                Row(
                  children: [
                    Text(label,style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.bold),),
                  ],
                ),
                const SizedBox(height: 5,),
                InkWell(
                  autofocus: true,
                  focusNode: FocusNode(),
                  onTap: ()=> {onTap(tag ?? 0),
                  FocusManager.instance.primaryFocus?.unfocus()},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(text,style: TextStyle(fontSize: 25,color:
                      textColor ?? Colors.black54,fontWeight: FontWeight.bold)),
                      Icon(data ?? Icons.keyboard_arrow_down_outlined,color: ThemeColors.PRIMARY_DARK,)
                    ],
                  ),
                ),
                const SizedBox(height: 1,),
                Line(color: ThemeColors.PRIMARY_DARK,),
              ]
          )
      );

}