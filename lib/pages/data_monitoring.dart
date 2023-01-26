
import 'package:burs_app/main.dart';
import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_model.dart';
import 'package:burs_app/pages/profile.dart';
import 'package:burs_app/widgets/dynamic_tab_bar.dart';
import 'package:burs_app/widgets/text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/predict_day_model.dart';
import '../theme.dart';
import '../widgets/data_element.dart';
import '../widgets/show_data_dialog.dart';

class DataMonitoring extends StatefulWidget{
  List<PredictModel> data;
  int current = 0;
  int currentChart = 0;
  DataMonitoring({super.key,required this.data});

  @override
  State<StatefulWidget> createState() => _dataMonitoring();

}
class _dataMonitoring extends State<DataMonitoring>{
  List<String> chartTitles = ['همه','داده و پیشبینی','بازه اطمینان اول','بازه اطمینان دوم'];

  String lastData = 'آخرین داده';
  List<String> predictTitles =['اولین روز پیشبینی','دومین روز پیشبینی','سومین روز پیشبینی','چهارمین روز پیشبینی',
    'پنجمین روز پیشبینی','ششمین روز پیشبینی','هفتمین روز پیشبینی','هشتمین روز پیشبینی',
    'نهمین روز پیشبینی','دهمین روز پیشبینی',
  ];

  int get getMin {
    int min = 9223372036854775807;
    List<DataDayModel> data = widget.data[widget.current].data;
    for(DataDayModel d in data.sublist(0,50))
      {
        if(d is PredictDayModel){
          if(min > d.min80) {
            // print('min 80 : ${d.index},${d.max80}');
            min = d.max80.toInt();
          }
        }
        else
          {
            if(min > d.main) {
              // print('main : ${d.index},${d.main}');
              min = d.main.toInt();
            }
          }
      }
    // print('min $min');
    return min;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: const Text('نمایش داده'),
        actions: [Padding(padding: const EdgeInsets.all(10),
          child: InkWell(child: const Icon(Icons.account_circle,size: 40,),
            onTap: (){Navigator.push(context, MaterialPageRoute(builder: (_) => const Profile()));},),),
          Padding(padding: const EdgeInsets.only(left: 10, right: 0,top: 15,bottom: 5),
              child:Image.asset('assets/images/img.png'))
        ],
      ),
      body: Center(
        child: ListView(
          children: children(),
        ),
      ),
    );
  }
  List<Widget> children(){
    List<Widget> result = List.empty(growable: true);

    ///tab bar
    result.add(SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 60,
        child:
        DynamicTabBar(data: List.generate(widget.data.length, (index) => widget.data[index].name),
          selected:widget.current,
          onItemClick: (i) => setState(()=> widget.current = i)
          ,
          onAddClick: (){
          Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'select a predict',
            onItemClick: (i,pm){
            setState(() {
              widget.data.add(pm!);
            });
            Navigator.pop(context);
            },)));
          },
        )
    ));

    ///chart
    result.add(Padding(padding: EdgeInsets.all(30),
        child:
        Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),color: Colors.white,
                boxShadow: List<BoxShadow>.filled(1, const BoxShadow(color: Colors.grey,blurRadius: 10))
            ),
            child: //Padding(padding: const EdgeInsets.all(0),child:
            Stack(children: [

              Center(child:
                FractionallySizedBox(widthFactor: 1.1,
                  child:lineChart(getCurrentChartSeries(),chartTitles[widget.currentChart])
                )
              ),
              Align(alignment: Alignment.topRight,child:
              FloatingActionButton.small(
                  heroTag: 'change map',
                  child: const Icon(Icons.replay),
                  onPressed: () => setState(()
                  =>
                    widget.currentChart = widget.currentChart == 3 ? 0 : ++widget.currentChart


                    ,))),
            ]
            )
        )
    )
    );

    ///days
    for(int i = 0; i < widget.data[widget.current].data.length; i++){
      result.add(DataElement(model: widget.data[widget.current].data[i],defaultName: getName(widget.data[widget.current].data[i]),));
    }
    return result;
  }
  Widget lineChart(List<ChartSeries<DataDayModel, String>> data,String title){
    return SfCartesianChart(
      // Initialize category axis
        primaryXAxis: CategoryAxis(isVisible: false),
        primaryYAxis: NumericAxis(isVisible: false),
        borderColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        plotAreaBackgroundColor: Colors.transparent,
        plotAreaBorderColor: Colors.transparent,

        // Chart title
        title: ChartTitle(text: title,),
        // Enable legend
        legend: Legend(isVisible: true,position: LegendPosition.bottom
            ,width: '280'

        ),
        // Enable tooltip
        tooltipBehavior: TooltipBehavior(enable: true,
            builder: (a,b,c,d,e){
          DataDayModel pdm = widget.data[widget.current].data.reversed.toList()[
            widget.data[widget.current].data.length + d -1  - getPr(getPredicts)];
          return SizedBox(width:pdm is PredictDayModel ? 110 : 90,height: pdm is PredictDayModel ? 85 : 45,
              child: Column(
                children: [
                  const SizedBox(height: 3,),
                  Text(getName(pdm),style: SpecialTextStyle(color: Colors.white,size: 10),),
                  const SizedBox(height: 3,),
                  Text('پیش بینی : ${pdm.main.toInt()}',style: SpecialTextStyle(color: Colors.white,size: 10),),
                  if(pdm is PredictDayModel)
                    const SizedBox(height: 3,),
                  if(pdm is PredictDayModel)
                    Text('بازه اول : ${pdm.max80.toInt()}-${pdm.min95.toInt()}',style: SpecialTextStyle(color: Colors.white,size: 10),),
                  if(pdm is PredictDayModel)
                    const SizedBox(height: 3,),
                  if(pdm is PredictDayModel)
                    Text('بازه دوم : ${pdm.max95.toInt()}-${pdm.min80.toInt()}',style: SpecialTextStyle(color: Colors.white,size: 10),),
                ],
              ),
          );
        }
        ),
        series:data
    );
  }

  List<ChartSeries<DataDayModel, String>> getCurrentChartSeries(){
    List<List<ChartSeries<DataDayModel, String>>> chartSeries =
    [
      [L2List(Colors.brown),L1List(),pastList(),mainList()],
      [mainList(),pastList(),L2List(Colors.transparent),],
      [L1List(),pastList(),L2List(Colors.transparent),],
      [L2List(Colors.brown),pastList(),]
    ];
    return chartSeries[widget.currentChart];
  }


  ChartSeries<DataDayModel, String> mainList() => LineSeries<DataDayModel, String>(
      color: ThemeColors.PRIMARY,
      name: 'پیشبینی',
      width: 3,
      // Bind data source
      dataSource:  past(widget.data[widget.current].data.reversed.toList(), getPredicts),
      xValueMapper: (DataDayModel model, _) => getName(model),
      yValueMapper: (DataDayModel model, _) => (model is PredictDayModel ||  (getName(model) == lastData))? (model).main-getMin : null
  );

  String getName(DataDayModel model){
    String s = (model is PredictDayModel) ? (model.name.isEmpty ? predictTitles[model.index-1] : model.name) :
    model.name.isEmpty ? (model.index == widget.data[widget.current].data.length - getPredicts ?lastData:'داده ${model.index}' ): model.name;
    //print((model.index == widget.data[widget.current].data.length - getPredicts ?lastData:'داده ${model.index}' ));
      return s;}
  ChartSeries<DataDayModel, String> pastList() => LineSeries<DataDayModel, String>(
      color: ThemeColors.DARK,
      name: 'داده',
      width: 3,
      // Bind data source
      dataSource:  past(widget.data[widget.current].data.reversed.toList(), getPredicts),
      xValueMapper: (DataDayModel model, _) => getName(model),
      yValueMapper: (DataDayModel model, _) => (model is PredictDayModel)
          ? null : (model).main-getMin
  );
  int get getPredicts {
    int result = 0;
    for(DataDayModel d in widget.data[widget.current].data)
    {
      if(d is PredictDayModel) {
        result++;
      } else {
        return result;
      }
    }
    return result;
  }
  List<DataDayModel> past(List<DataDayModel> models,int pr){
    return models.sublist(models.length - 1 - getPr(pr),models.length);
  }
  int getPr(int i) => i < 7 ? 15 : 2*i;
  ChartSeries<DataDayModel, String> L1List() =>
    RangeAreaSeries<DataDayModel, String>(
      dataSource: past(widget.data[widget.current].data.reversed.toList(), getPredicts),
      name: 'بازه اطمینان اول',
      borderWidth: 2,
      opacity: 0.5,
      color: Color(0xF5DEBC),//ThemeColors.PRIMARY_DARK,
      borderDrawMode: RangeAreaBorderMode.excludeSides,
      xValueMapper: (DataDayModel sales, _) => getName(sales),
      highValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel)? (sales).max80-getMin : ((getName(sales) == lastData) ?(sales.main-getMin):null),
      lowValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel ) ? (sales).min95-getMin :((getName(sales) == lastData) ?(sales.main-getMin):null),
      //  highValueMapper:(DataDayModel sales, _) => 15000,
      //lowValueMapper: (DataDayModel sales, _) =>10000,
    );
  ChartSeries<DataDayModel, String> L2List(Color color) =>RangeAreaSeries<DataDayModel, String>(

    dataSource: past(widget.data[widget.current].data.reversed.toList(), getPredicts),
    name: 'بازه اطمینان دوم',
    borderWidth: 2,
    opacity: 0.5,
   //borderColor: Colors.brown,//ThemeColors.PRIMARY_LIGHT,
    color: color,//ThemeColors.PRIMARY_LIGHT,
    borderDrawMode: RangeAreaBorderMode.excludeSides,
    xValueMapper: (DataDayModel sales, _) => getName(sales),
    highValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel)? (sales).max95-getMin : ((getName(sales) == lastData) ?(sales.main-getMin):null),
    lowValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel ) ? (sales).min80-getMin :((getName(sales) == lastData) ?(sales.main-getMin):null),
  );


}