import 'package:burs_app/widgets/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DynamicTabElement extends StatelessWidget{
  final String text;
  final bool? selected;
  final Color? back;
  final Color? front;
  final int? index;
  final Function(int)? onClick;

  const DynamicTabElement({super.key,
  required this.text,
  this.selected,
  this.back,
  this.front,
  this.index,
  this.onClick});


  @override
  Widget build(BuildContext context) => Padding(padding: EdgeInsets.only(top : 15,left: 5,right: 5,bottom: 10),
    child: InkWell(
      onTap: ()=>onClick == null ?null:onClick!(index??0),
      child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(40)),
            color: selected??false ? front ?? ThemeColors.PRIMARY_DARK : back ?? ThemeColors.PRIMARY_LIGHT,

            boxShadow: [
              if(!(selected??false))
                const BoxShadow(color: Colors.grey,blurRadius: 15)
            ]
          ),
          child: Center(
            child: Text(text,style:
            SpecialTextStyle(size: 18,color: selected??false ? back ?? ThemeColors.LIGHT : front ?? ThemeColors.PRIMARY_DARK),),
          )
      ),
    ),
  );

}