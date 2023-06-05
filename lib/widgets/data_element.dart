import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_day_model.dart';
import 'package:burs_app/widgets/show_data_dialog.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class DataElement extends StatelessWidget{
  final double? width;
  final double? height;
  final DataDayModel model;
  final String? defaultName;
  DataElement({super.key, this.width, this.height,required this.model, this.defaultName});
  final String lastData = 'آخرین داده';

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
          onPressed: isPredict ?
              (){
              showDialog(

              context: context,
              builder: (_) => ShowDataDialog(model: model as PredictDayModel,onCancel: (){Navigator.of(context).pop();},),
              );
              }
          : null,
          child: Padding(padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(getName(model),
                      style: TextStyle(color: isPredict ?ThemeColors.LIGHT: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),

                Text(model.main.toInt().toString(),
                    style: TextStyle(color: isPredict ?ThemeColors.LIGHT: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),

              ],
            )
          ),)
      ,)
    );
  }
  String getName(DataDayModel model) => model.name.isEmpty ? defaultName??'' : model.name;

}