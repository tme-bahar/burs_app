import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_day_model.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DataElement extends StatelessWidget{
  final double? width;
  final double? height;
  final DataDayModel model;
  const DataElement({super.key, this.width, this.height,required this.model});

  @override
  Widget build(BuildContext context) {
    const double height = 75;
    const double paddingHorizontal = 25;
    const double paddingVertical = 5;
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: paddingHorizontal,vertical: paddingVertical);
    bool isPredict = model is PredictDayModel;
    return Container(color: ThemeColors.LIGHT
    ,width: width ?? MediaQuery.of(context).size.width
    ,height: this.height ?? height + 2,
    child: Padding(padding: padding,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                  )
              ),
            elevation: MaterialStateProperty.all(isPredict ? 5 : 0),
            backgroundColor: MaterialStateProperty.all(isPredict ?ThemeColors.PRIMARY_DARK: ThemeColors.PRIMARY_LIGHT)
          ),
          onPressed: isPredict ? ()=>{  } : null,
          child: Padding(padding: EdgeInsets.all(5),
            child: Stack(
              children: [
                Align(alignment: Alignment.centerLeft,
                  child: Text(model.name,
                      style: TextStyle(color: isPredict ?ThemeColors.LIGHT: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),
                ),
                Align(alignment: Alignment.centerRight,
                  child: Text(model.main.toString(),
                    style: TextStyle(color: isPredict ?ThemeColors.LIGHT: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),
                )
              ],
            )
          ),)
      ,)
    );
  }

}