import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_day_model.dart';
import 'package:burs_app/widgets/show_data_dialog.dart';
import 'package:flutter/material.dart';

import '../theme.dart';

class FileElement extends StatelessWidget{
  final double? width;
  final double? height;
  final String? text;
  const FileElement({super.key, this.width, this.height,this.text});

  @override
  Widget build(BuildContext context) {
    const double height = 40;
    const double paddingHorizontal = 25;
    const double paddingVertical = 5;
    const EdgeInsets padding = EdgeInsets.symmetric(horizontal: paddingHorizontal,vertical: paddingVertical);
    bool isPredict = false;
    return Container(color: ThemeColors.LIGHT
    ,width: width ?? MediaQuery.of(context).size.width
    ,height: this.height ?? height + 2,
    child: Padding(padding: padding,
      child: ElevatedButton(
          style: ButtonStyle(
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    side: BorderSide(color: ThemeColors.PRIMARY_DARK),
                      borderRadius: BorderRadius.circular(18.0),
                  ),
              ),
            elevation: MaterialStateProperty.all(isPredict ? 5 : 0),
            backgroundColor: MaterialStateProperty.all(Colors.transparent)
          ),
          onPressed:
          // isPredict ?
          //     (){
          //     showDialog(
          //
          //     context: context,
          //     builder: (_) => ShowDataDialog(model: model as PredictDayModel,onCancel: (){Navigator.of(context).pop();},),
          //     );
          //     }
          // :
          null,
          child: Padding(padding: EdgeInsets.all(5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(text?? '',style: TextStyle(color: ThemeColors.PRIMARY_DARK,fontSize: 10),),
              ],
            )
          ),)
      ,)
    );
  }

}