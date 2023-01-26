

import 'package:burs_app/widgets/combo_box.dart';
import 'package:burs_app/widgets/special_button.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/customized_text_field.dart';
import '../widgets/line.dart';
import '../widgets/radio_dialog.dart';

class GetData extends StatefulWidget{
  const GetData({super.key});

  @override
  State<StatefulWidget> createState() => _getData();

}
class _getData extends State<GetData>{
  List<TextEditingController> controller = [TextEditingController(),TextEditingController(),TextEditingController()];

  List<String> justifyChooses = ['خیر','افزایش سرمایه','افزایش سرمایه + سود'];
  String selectedJustify = 'انتخاب کنید';
  int selectedJustifyIndex = 0;

  List<String> predictData = ['اولین قیمت','بیشترین قیمت','کمترین قیمت','آخرین قیمت','قیمت پایانی'];
  String selectedPredictData = 'انتخاب کنید';
  int selectedPredictDataIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: const Text('دریافت آنلاین'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            CustomizedTextField(label: 'نام نماد',hint: 'یک نام بنویسید',
                c: controller[0],type: TextInputType.text,max: 100,),

            CustomizedTextField(label: 'تاریخ شروع',hint: '1401.06.22',
              c: controller[1],type: TextInputType.number,max: 10,mask: 'xxxx.xx.xx',),
            const SizedBox(height: 20,),
            CustomizedTextField(label: 'تاریخ پایان',hint: '1401.06.23',
              c: controller[2],type: TextInputType.number,max: 10,mask: 'xxxx.xx.xx',),
            const SizedBox(height: 20,),

            ComboBox(label: 'تعدیل قیمت', text: selectedJustify, onTap: (i){
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => RadioDialog(
                    selectedRadio: selectedJustifyIndex,
                    data: justifyChooses,
                    onFinished: (i){
                      setState(() {
                        selectedJustify = justifyChooses[i];
                        selectedJustifyIndex = i;
                        Navigator.pop(context);
                      });
                    },));
            },
              textColor: selectedJustify == 'انتخاب کنید' ? null : ThemeColors.DARK,
            ),

            const SizedBox(height: 20,),
            ComboBox(label: 'داده پیشبینی', text: selectedPredictData, onTap: (i){
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => RadioDialog(
                    selectedRadio: selectedPredictDataIndex,
                    data: predictData,
                    onFinished: (i){
                      setState(() {
                        selectedPredictData = predictData[i];
                        selectedPredictDataIndex = i;
                        Navigator.pop(context);
                      });
                    },));
            },
              textColor: selectedPredictData == 'انتخاب کنید' ? null : ThemeColors.DARK,
            ),

            const SizedBox(height: 20,),
            Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              child:
                SpecialButton(
                  onPressed: ()=>Navigator.pop(context),
                  backGroundColor: ThemeColors.PRIMARY_DARK,
                  children: [
                    Text('دریافت',style: _style(null,ThemeColors.LIGHT),)
                  ],
                )
            ),

          ]
        ),
      ),
    );
  }

  TextStyle _style([double? size,Color? color]) =>
      TextStyle(color: color ?? ThemeColors.PRIMARY_DARK,fontSize: size ?? 15,
      fontWeight: FontWeight.bold);

  Icon _ic(IconData data) => Icon(data,color: ThemeColors.PRIMARY_DARK,);
}