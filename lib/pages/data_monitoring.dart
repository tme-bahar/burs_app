
import 'package:burs_app/main.dart';
import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_model.dart';
import 'package:burs_app/pages/profile.dart';
import 'package:burs_app/widgets/dynamic_tab_bar.dart';
import 'package:burs_app/widgets/line.dart';
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
  List<String> predictTitles =['اول','دوم','سوم','چهارم',
    'پنجم','ششم','هفتم','هشتم',
    'نهم','دهم','یازدهم','دوازدهم','سیزدهم','چهاردهم','پانزدهم'
    ,'شانزدهم','هفدهم','هجدهم','نوزدهم','بیستم','بیست و یکم','بیست و دوم',
    'بیست و سوم','بیست و چهارم','بیست و پنجم',
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
    return Row(
      children: [
        if(MediaQuery.of(context).size.width > 700)
          SizedBox(width: 300,child:MyHomePage(title: 'پیش بینی ها')),
        if(MediaQuery.of(context).size.width > 700)
          Line(height: MediaQuery.of(context).size.width,width: 1,color: const Color(0xFFE8F1F2),),
        SizedBox(width: MediaQuery.of(context).size.width-(MediaQuery.of(context).size.width > 700 ? 301 : 0),child: monitor,),
      ],
    );

  }
  
  Widget get monitor => Scaffold(

    backgroundColor: ThemeColors.LIGHT,
    appBar:
      MediaQuery.of(context).size.width > 700?null:
        AppBar(title: const Text('نمایش داده'),),
    body: Center(
      child: ListView(
        children: children(),
      ),
    ),
  );
  List<Widget> children(){
    List<Widget> result = List.empty(growable: true);

    ///tab bar
    // result.add(SizedBox(
    //     width: MediaQuery.of(context).size.width,
    //     height: 60,
    //     child:
    //     DynamicTabBar(data: List.generate(widget.data.length, (index) => widget.data[index].name),
    //       selected:widget.current,
    //       onItemClick: (i) => setState(()=> widget.current = i)
    //       ,
    //       onAddClick: (){
    //         Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage(title: 'یک پیش بینی انتخاب کنید',
    //           onItemClick: (i,pm){
    //             setState(() {
    //               widget.data.add(pm!);
    //             });
    //             Navigator.pop(context);
    //           },)));
    //       },
    //     )
    // ));

    ///chart
    result.add(Padding(padding: EdgeInsets.all(30),
        child:
        Container(
            decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),color: Colors.white,
                boxShadow: List<BoxShadow>.filled(1, const BoxShadow(color: Colors.grey,blurRadius: 10))
            ),
            height: MediaQuery.of(context).size.width*0.4,
            child: //Padding(padding: const EdgeInsets.all(0),child:
            Stack(children: [

              Center(child:
              FractionallySizedBox(widthFactor: 1,
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
    // for(int i = 0; i < widget.data[widget.current].data.length; i++){
    //   result.add(DataElement(model: widget.data[widget.current].data[i],defaultName: getName(widget.data[widget.current].data[i]),));
    // }

    result.add(Padding(padding: EdgeInsets.all(10),child: Text('پیش بینی ها',style: _style,),));
    ///predicts
    result.add(
        DataTable(columns: [
          DataColumn(label: Text('عنوان',style: _style,),),
          DataColumn(label: Text('پیش بینی',style: _style,),),
          if(MediaQuery.of(context).size.width > 1100)
          DataColumn(label: Text('کران بالای بازه اطمینان اول',style: _style,),),
          if(MediaQuery.of(context).size.width > 1100)
          DataColumn(label: Text('کران پایین بازه اطمینان اول',style: _style,),),
          if(MediaQuery.of(context).size.width > 1500)
          DataColumn(label: Text('کران بالای بازه اطمینان دوم',style: _style,),),
          if(MediaQuery.of(context).size.width > 1500)
          DataColumn(label: Text('کران پایین بازه اطمینان دوم',style: _style,),),
        ],
            //rows: [],
            rows: List.generate(widget.data[widget.current].p, (index1) =>
            DataRow(cells: [
              DataCell(Text(getName(widget.data[widget.current].data[index1]))),
              DataCell(Text(widget.data[widget.current].data[index1].main.toInt().toString())),
              if(MediaQuery.of(context).size.width > 1100)
              DataCell(Text(((widget.data[widget.current].data[index1] as PredictDayModel).max80.toInt().toString()))),
              if(MediaQuery.of(context).size.width > 1100)
                DataCell(Text(((widget.data[widget.current].data[index1] as PredictDayModel).min95.toInt().toString()))),
              if(MediaQuery.of(context).size.width > 1500)
              DataCell(Text(((widget.data[widget.current].data[index1] as PredictDayModel).max95.toInt().toString()))),
              if(MediaQuery.of(context).size.width > 1500)
              DataCell(Text(((widget.data[widget.current].data[index1] as PredictDayModel).min80.toInt().toString()))),
            ],
              onSelectChanged: (v)=>showDialog(

                context: context,
                builder: (_) => ShowDataDialog(model: widget.data[widget.current].data[index1] as PredictDayModel,onCancel: (){Navigator.of(context).pop();},),
              ),
            )
            ),
          showCheckboxColumn: false,
        )
    );
    result.add(Padding(padding: EdgeInsets.all(10),child: Text('داده ها',style: _style,),));

    ///data
    result.add(
        DataTable(columns: [
          DataColumn(label: Text('عنوان',style: _style,),),
          DataColumn(label: Text('داده',style: _style,),),
        ],
            //rows: [],
            rows: List.generate(widget.data[widget.current].data.length - widget.data[widget.current].p, (index1) =>
                DataRow(cells: [
                  DataCell(Text(getName(widget.data[widget.current].data[index1+widget.data[widget.current].p]))),
                  DataCell(Text(widget.data[widget.current].data[index1+widget.data[widget.current].p].main.toInt().toString())),
                ]))
        )
      //DataElement(model: widget.data[widget.current].data[i],defaultName: getName(widget.data[widget.current].data[i]),)
    );

    return result;
  }

  TextStyle get _style => const TextStyle(color: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 15);


  Widget  tab(List<DataColumn> columns,List<DataRow> rows) => DataTable(columns: columns,rows: rows);


  Widget lineChart(List<ChartSeries<DataDayModel, String>> data,String title)=> SfCartesianChart(
    // Initialize category axis
      primaryXAxis: CategoryAxis(isVisible: false),
      primaryYAxis: NumericAxis(isVisible: true,minimum: getMin.toDouble(),),
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
      // onPointTap: (c)=>
      //     ShowDataDialog(
      //       model: widget.data[widget.current].data[(getPr(getPredicts)-(c.viewportPointIndex??-1)).toInt()] as PredictDayModel,
      //       onCancel: (){Navigator.of(context).pop();},),

      // Bind data source
      dataSource:  past(widget.data[widget.current].data.reversed.toList(), getPredicts),
      xValueMapper: (DataDayModel model, _) => getName(model),
      yValueMapper: (DataDayModel model, _) => (model is PredictDayModel ||  (getName(model) == lastData))? (model).main
          : null
  );

  String getName(DataDayModel model){
    String s = (model is PredictDayModel) ? (model.name.isEmpty ? 'پیش بینی برای دوره ${predictTitles[model.index-1]}' : model.name) :
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
          ? null : (model).main
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
        highValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel)? (sales).max80 : ((getName(sales) == lastData) ?(sales.main):null),
        lowValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel ) ? (sales).min95 :((getName(sales) == lastData) ?(sales.main):null),
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
    highValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel)? (sales).max95 : ((getName(sales) == lastData) ?(sales.main):null),
    lowValueMapper: (DataDayModel sales, _) => (sales is PredictDayModel ) ? (sales).min80 :((getName(sales) == lastData) ?(sales.main):null),
  );


}