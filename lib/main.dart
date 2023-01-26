
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
    return MaterialApp(

        localizationsDelegates: const [
          GlobalCupertinoLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: const [
          Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
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
  List<PredictModel>? allData;
  final Function(int,PredictModel?)? onItemClick;
  MyHomePage({super.key, required this.title, this.onItemClick});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {

    LocalData.getLocalData().then((value) => setState(()=>widget.allData=value));

    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [Padding(padding: const EdgeInsets.all(10),
          child: InkWell(child: const Icon(Icons.account_circle,size: 40,),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile()));},),)
          ,
            Padding(padding: const EdgeInsets.only(left: 10, right: 0,top: 15,bottom: 5),
            child:Image.asset('assets/images/img.png'))
        ],

      ),
      body: Center(
        child: Column(
          children: children(widget.allData),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: 'add',
        onPressed: ()=>_gotoAdd(null,null,null,null,null,null,null),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
            //_gotoAdd(p!.name,p.p,p.c,p.t,p.L1i,p.L2i),
          )
        );
      }
    }
    return result;

  }

  Center getText(String text) => Center(child: Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);

  showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(right: 7),child:Text("در حال بار گزاری" )),
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
          Net.addProduct(f!).then((value){
            semaphor--;
            if(semaphor == 0) {
              Net.afterUpload(current,()=>setState(() {
                widget.allData!.remove(temp);
                Navigator.pop(context);
              }));

            }
          });
          String data = toPHP(n, p, c, t, L1, L2, ch(10));
          FileStorage fs = FileStorage(name:'data.php');
          File dataFile = await fs.write(data);
          Net.addProduct(dataFile).then((value){
            semaphor--;
            if(semaphor == 0) {
              Net.afterUpload(current,()=>setState(() {
                widget.allData!.remove(temp);
                Navigator.pop(context);
              }));
            }
          });
        }
      )));
    });
  }

  String toPHP(String n,int p,int c,String t,int L1,int L2,String s) => 
      '<?php ${ec('value')} $s ${e(L1)} $s ${e(L2)} $s ${e(p)} $s ${ec(t)} ?>';
  String ec(String i) => 'echo($i);';
  String e(int i) => 'echo($i);';
  String ch(int i) => ec('chr($i)');
}
