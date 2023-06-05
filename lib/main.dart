
import 'dart:convert';
import 'dart:io';

import 'package:burs_app/models/predict_model.dart';
import 'package:burs_app/pages/data_monitoring.dart';
import 'package:burs_app/pages/new_predict.dart';
import 'package:burs_app/pages/profile.dart';
import 'package:burs_app/theme.dart';
import 'package:burs_app/widgets/divider.dart';
import 'package:burs_app/widgets/home_list_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'data/local.dart';
import 'data/net.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //LocalData.clearAll(15);
    return MaterialApp(

        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"),
        ],

      locale: const Locale('fa','IR'),
      title: 'دمو',
      theme: ThemeData(
        fontFamily: 'Vazir',
        primarySwatch: //Colors.green
        MaterialColor(

        ThemeColors.PRIMARY_DARK.value,
        const <int, Color>{
          50: Color(0xFFE8F5E9),
          100: Color(0xFFC8E6C9),
          200: Color(0xFFA5D6A7),
          300: Color(0xFF81C784),
          400: Color(0xFF66BB6A),
          500: ThemeColors.PRIMARY_DARK,
          600: Color(0xFF43A047),
          700: Color(0xFF388E3C),
          800: Color(0xFF2E7D32),
          900: Color(0xFF1B5E20),
        },
      )
      ),
      home: MyHomePage(
          title: 'صفحه خانه'
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  List<PredictModel>? allData = List.empty(growable: true);
  final Function(int,PredictModel?)? onItemClick;
  MyHomePage({super.key, required this.title, this.onItemClick});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
bool ran = false;

  @override
  Widget build(BuildContext context) {
    //LocalData.clearAll(13);
    LocalData.getLocalData().then((value) => setState(()=>widget.allData=value));
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,

      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(widget.title),
        actions: [
          Padding(padding: const EdgeInsets.only(top: 10,bottom: 10),
              child:InkWell(
                  onTap: ()=> showAlertDialog(context, 'حذف داده های اپ',
                      'آیا با حذف داده های اپلیکیشن موافقید؟ این کار باعث حذف تمامی پیش بینی ها می شود!', 'حذف', 'لغو',
                          (){LocalData.clearAll(50);Navigator.pop(context);}),
                  child: const Icon(Icons.delete_forever,color: Colors.red,))),
          Padding(padding: const EdgeInsets.all(10),
          child: InkWell(child: const Icon(Icons.account_circle,size: 40,),
            onTap: (){showDialog(
                context: context,
                builder: (v)=>Profile(),

            );
            },),)
          ,
            // Padding(padding: const EdgeInsets.only(left: 10, right: 0,top: 15,bottom: 5),
            // child:Image.asset('assets/images/img.png'),),

        ],

      ),
      body: Center(
        child: ListView(
          children: children(widget.allData),
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   heroTag: 'add',
      //   onPressed: ()=>_gotoAdd(null,null,null,null,null,null,null),
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }


  showAlertDialog(BuildContext context,String title,String text,String ok,String cancel,VoidCallback okCall) {

  // set up the button
  Widget okButton = TextButton(
    child: Text(ok),
    onPressed: okCall,
  );
  Widget cancelButton = TextButton(
    child: Text(cancel),
    onPressed: ()=>Navigator.of(context).pop(),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(text),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}


  List<Widget> children(List<PredictModel>? allData){
    List<Widget> result = List.empty(growable: true);

    result.addAll([const SizedBox(height: 5,),
      HomeListElement(title: 'افزودن پیشبینی جدید',
        circleChild: const Icon(Icons.add),onTap: (i,pm)=>_gotoAdd(null,null,null,null,null,null,null),),
      const ThickDivider(text: 'پیشبینی های قبلی',),]);

    if(allData != null) {
      for (PredictModel pm in allData) {
        result.add(
          HomeListElement(title: pm.name,circleChild: getText(pm.index.toString()),
              pm: pm,
              onTap: widget.onItemClick ?? (i,pm) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) =>
                      DataMonitoring( data: [pm!],)
                  )
                  );
                }
                );
          },
          onDuplicateTap:(i,p)=> _gotoAdd(p!.name,p.p,p.c,p.t,p.L1i,p.L2i,p.filePath),
            onDeleteTap: (i,p)=>showDeleteAlertDialog(context, p!.name,()=>LocalData.deletePr(p.name, context)),
          )
        );
      }
    }

    result.add(const SizedBox(height: 100,));
    return result;

  }

  Center getText(String text) => Center(child: Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);

  showDeleteAlertDialog(BuildContext context,String name,VoidCallback ok) {

    // set up the button
    Widget okButton = TextButton(
      onPressed: (){ok();Navigator.of(context).pop();},
      child: const Text("بله"),
    );
    Widget noButton = TextButton(
      child: const Text("خیر"),
      onPressed: ()=>Navigator.of(context).pop(),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(" حذف $name"),
      content: Text("آیا مطمئنید که $name حذف شود ؟ "),
      actions: [
        noButton,
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: Row(
        children: [
          const CircularProgressIndicator(),
          Container(margin: const EdgeInsets.only(right: 7),child:const Text("در حال بار گزاری" )),
        ],),
    );
    showDialog(barrierDismissible: false,
      context:context,
      builder:(BuildContext context){
        return alert;
      },
    );
  }

  void _gotoAdd(String? name,int? p, int? c,int? t,int? L1i,int? L2i,String? path){
    int semaphor  = 2;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => NewPredict(
        data: path == null ? null:File(path),
        name: name,
        p: p,
        c: c,
        L1i: L1i,
        L2i: L2i,
        t: t,
        onAddClick: (n,p,c,t,L1,L2,f) async {
          PredictModel temp = PredictModel([], name: n, index: 0,c: 0,L1i: 0,L2i: 0,p: 0,t: 0,
              filePath: f == null ? '' : f.path);
          PredictModel current = PredictModel([], name: n, index: 0,c: c,L1i: L1,L2i: L2,p: p,t: int.parse(t),
              filePath: f == null ? '' : f.path);
          setState(() {
            widget.allData!.add(temp);
            showLoaderDialog(context);
            print(widget.allData!.length);
          });
          Net.addProduct(f!,context).then((value){
            semaphor--;
            if(semaphor == 0) {
              Net.afterUpload(current,()=>setState(() {
                Navigator.pop(context);
              }),context);

            }
          });
          String data = toPHP(n, p, c, t, L1, L2, ch(10));
          FileStorage fs = FileStorage(name:'data.php');
          File dataFile = await fs.write(data);
          Net.addProduct(dataFile,context).then((value){
            semaphor--;
            if(semaphor == 0) {
              Net.afterUpload(current,()=>setState(() {
                ///widget.allData!.remove(temp);
                Navigator.pop(context);
              }),context);
            }
          });
        }
      )));
    });
  }

  //void Snack(String text) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text),));

  String toPHP(String n,int p,int c,String t,int L1,int L2,String s) => 
      '<?php ${ec('value')} $s ${e(L1)} $s ${e(L2)} $s ${e(p)} $s ${ec(t)} $s ${e(c)} ?>';
  String ec(String i) => 'echo($i);';
  String e(int i) => 'echo($i);';
  String ch(int i) => ec('chr($i)');
}
