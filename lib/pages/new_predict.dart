


import 'dart:io';

import 'package:burs_app/widgets/combo_box.dart';
import 'package:burs_app/widgets/file_element.dart';
import 'package:burs_app/widgets/radio_dialog.dart';
import 'package:burs_app/widgets/special_button.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import '../theme.dart';
import '../widgets/customized_text_field.dart';
import 'get_data.dart';

class NewPredict extends StatefulWidget{
  final String? name;
  final int? p;
  final int? c;
  final int? t;
  final int? L1i;
  final int? L2i;
  File? data;
  final Function(String name,int predictNumber,int decideNumber,String type,int L1,int L2,File? data) onAddClick;
  NewPredict({super.key,this.data, required this.onAddClick, this.name, this.p, this.c, this.t, this.L1i, this.L2i});

  @override
  State<StatefulWidget> createState() => _newPredict();

}
class _newPredict extends State<NewPredict>{

  List<TextEditingController> controller = [TextEditingController(),TextEditingController(),TextEditingController()];
  List<String> types = ['اول','دوم','سوم'];
  String selectedType = 'انتخاب کنید';
  int selectedTypeIndex = 4;

  List<String> L1 = ['80','75','70'];
  String selectedL1 = 'انتخاب کنید';
  int selectedL1Index = 4;

  List<String> L2 = ['95','90','85'];
  String selectedL2 = 'انتخاب کنید';
  int selectedL2Index = 4;
  bool loaded = false;

  //RadioDialog type = RadioDialog(data: types,);
  @override
  Widget build(BuildContext context) {
    if(selectedL1Index == 4 && !loaded) {
      selectedL1 = widget.L1i == null ? 'انتخاب کنید' : L1[widget.L1i!];
      selectedL1Index = widget.L1i ?? 4;
    }
    if(selectedL2Index == 4 && !loaded) {
      selectedL2 = widget.L2i == null ? 'انتخاب کنید' : L2[widget.L2i!];
      selectedL2Index = widget.L2i ?? 4;
    }
    if(selectedTypeIndex == 4 && !loaded) {
      selectedType = widget.t == null ? 'انتخاب کنید' : types[widget.t!-1];
      selectedTypeIndex = (widget.t ?? 5)-1;
    }

    if(widget.p != null && !loaded) {
      controller[1].text = (widget.p).toString();
    }
    if(widget.c != null && !loaded) {
      controller[2].text = (widget.c).toString();
    }
    if(widget.name != null && !loaded) {
      controller[0].text = widget.name!;
    }
    loaded = true;
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: const Text('پیشبینی جدید'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            const SizedBox(height: 20,),
            CustomizedTextField(label: 'نام پیشبینی',hint: 'یک نام بنویسید',
                c: controller[0],type: TextInputType.text,max: 100,),
            CustomizedTextField(label: 'تعداد روز های پیشبینی',hint: 'یک عدد بنویسید',
                c: controller[1],type: TextInputType.number,max: 4,),
            CustomizedTextField(label: 'تعداد روز های مبنای تصمیم گیری',
              hint: 'یک عدد بنویسید',
                helper: 'خالی بودن به معنای در نظر گرفتن تمام داده ها می باشد',
                c: controller[2],type: TextInputType.number,max: 4,),

            const SizedBox(height: 15,),
            ComboBox(label: 'روش', text: selectedType, onTap: (i){
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => RadioDialog(
                    selectedRadio: selectedTypeIndex,
                    data: types,
                    onFinished: (i){
                    setState(() {
                      selectedType = types[i];
                      selectedTypeIndex = i;
                      Navigator.pop(context);
                    });
                  },));
            },
              textColor: selectedType == 'انتخاب کنید' ? null : ThemeColors.DARK,
            ),
            const SizedBox(height: 25,),
            ComboBox(label: 'بازه اطمینان اول', text: selectedL1, onTap: (i){
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => RadioDialog(
                    selectedRadio: selectedL1Index,
                    data: L1,
                    onFinished: (i){
                      setState(() {
                        selectedL1 = L1[i];
                        selectedL1Index = i;
                        Navigator.pop(context);
                      });
                    },));
            },
            textColor: selectedType == 'انتخاب کنید' ? null : ThemeColors.DARK,),
            const SizedBox(height: 25,),
            ComboBox(label: 'بازه اطمینان دوم', text: selectedL2, onTap: (i){
              showDialog<void>(
                  context: context,
                  builder: (BuildContext context) => RadioDialog(
                    selectedRadio: selectedL2Index,
                    data: L2,
                    onFinished: (i){
                      setState(() {
                        selectedL2 = L2[i];
                        selectedL2Index = i;
                        Navigator.pop(context);
                      });
                    },));
            },
            textColor: selectedType == 'انتخاب کنید' ? null : ThemeColors.DARK,),
            const SizedBox(height: 25,),
            Padding(padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
            child:Text('داده قبلی از کجا دریافت شود ؟',style: _style(20),),),

            Padding(padding: const EdgeInsets.symmetric(vertical: 15,horizontal: 20),
              child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: (MediaQuery.of(context).size.width/ 2) - 40,
                    child:SpecialButton(
                        children: [
                          _ic(Icons.file_copy_outlined),
                          Text('  از فایل',style: _style(),),
                        ],
                        onPressed:()async {
                          FilePickerResult? result = await FilePicker.platform.pickFiles(allowMultiple: true);

                          if (result != null) {
                            List<File> files = result.paths.map((path) => File(path)).toList();
                            setState(() {
                              widget.data = files[0];
                            });
                          } else {
                            // User canceled the picker
                          }
                        }
                    )
                  ),

                  const SizedBox(width: 10,),

                  SizedBox(width: (MediaQuery.of(context).size.width/ 2) - 40,
                    child:SpecialButton(
                        children :[
                          _ic(Icons.download_sharp),
                          Text('آنلاین',style: _style(),),
                        ],
                        onPressed: ()=>
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const GetData()))

                    )
                  )
                ]
                )
            ),
            if(widget.data != null)
              Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
                  child:FileElement(text: widget.data!.path.split('/').last,)
              ),

            Padding(padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 20),
              child:
                SpecialButton(
                  onPressed: ()=>{Navigator.pop(context),widget.onAddClick(
                      controller[0].text,int.parse(controller[1].text),int.parse(controller[2].text),
                      (selectedTypeIndex+1).toString(),int.parse(selectedL1),int.parse(selectedL2),widget.data
                  )},
                  backGroundColor: ThemeColors.PRIMARY_DARK,
                  children: [
                    Text('افزودن',style: _style(null,ThemeColors.LIGHT),)
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