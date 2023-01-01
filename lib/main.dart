import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_day_model.dart';
import 'package:burs_app/pages/data_monitoring.dart';
import 'package:burs_app/theme.dart';
import 'package:burs_app/widgets/data_element.dart';
import 'package:burs_app/widgets/divider.dart';
import 'package:burs_app/widgets/home_list_element.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: //Colors.green
        MaterialColor(
        ThemeColors.PRIMARY_DARK.value,
        <int, Color>{
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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: Text(widget.title),
        actions: [Padding(padding: const EdgeInsets.all(10),
          child: InkWell(child: const Icon(Icons.account_circle,size: 40,),onTap: (){},),)],
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 5,),
            const HomeListElement(title: 'add new predict',circleChild: Icon(Icons.add)),
            const ThickDivider(text: 'recent predicts',),
            HomeListElement(title: 'predict1',circleChild: getText('1'),
              onTap: (i) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => DataMonitoring()));
                });
              }),
            HomeListElement(title: 'predict2',circleChild: getText('2')),
            HomeListElement(title: 'predict3',circleChild: getText('3')),
            HomeListElement(title: 'predict4',circleChild: getText('4')),
            //DataElement(model: PredictDayModel(main : 50,name: '2020.2.7', max95: 60, min95: 40, max80: 80, min80: 30))
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Center getText(String text) => Center(child: Text(text,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),);
}
