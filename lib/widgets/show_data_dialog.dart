import 'package:burs_app/models/predict_day_model.dart';
import 'package:burs_app/theme.dart';
import 'package:burs_app/widgets/data_line_chart.dart';
import 'package:flutter/material.dart';

import '../models/data_day_model.dart';

class ShowDataDialog extends StatelessWidget{
  final PredictDayModel model;
  final VoidCallback onCancel;
  ShowDataDialog({super.key,required this.model, required this.onCancel});
  final String lastData = 'آخرین داده';
  final List<String> predictTitles =['اولین روز پیشبینی','دومین روز پیشبینی','سومین روز پیشبینی','چهارمین روز پیشبینی',
    'پنجمین روز پیشبینی','ششمین روز پیشبینی','هفتمین روز پیشبینی','هشتمین روز پیشبینی',
    'نهمین روز پیشبینی','دهمین روز پیشبینی',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20,vertical:  (MediaQuery.of(context).size.height/2)-210),
      decoration: const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),color: ThemeColors.LIGHT,
      ),
      child:
        Column(
          children: [
            getRow([
              Text(getName(model),
                style: const TextStyle(color: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),

              Material(
                child: InkWell(splashColor: ThemeColors.LIGHT,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onTap: ()=>onCancel(),
                  child: const Icon(Icons.cancel,size: 30,),),
              ),
            ],),
            DataLineChart(main: model.main.toDouble(), max1: model.max95.toDouble(),
                max2: model.max80.toDouble(), min1: model.min95.toDouble(), min2: model.min80.toDouble()),
            getTextRow('پیش بینی', model.main.toInt().toString(),false),
            getTextRow('کران بالای بازه اطمینان 95%', model.max80.toInt().toString(),true),
            getTextRow('کران پایین بازه اطمینان 95%', model.min95.toInt().toString(),false),
            getTextRow('کران بالای بازه اطمینان 80%', model.max95.toInt().toString(),true),
            getTextRow('کران پایین بازه اطمینان 80%', model.min80.toInt().toString(),false),
          ],
        )
    );

  }
  String getName(DataDayModel model){
    String s = (model is PredictDayModel) ? (model.name.isEmpty ? predictTitles[model.index] : model.name) :
    model.name.isEmpty ? 'داده ${model.index}' : model.name;
    print(s);
    return s;}
  Padding getRow(List<Widget> children) => Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children,
    ),
  );
  Padding getTextRow(String text1,String text2,bool isEven) =>
      Padding(padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(text1,
          style: TextStyle(color: isEven ? ThemeColors.PRIMARY : ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),
        Text(text2,
          style: TextStyle(color: isEven ? ThemeColors.PRIMARY : ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 18),),
      ],
    ),
  );
}