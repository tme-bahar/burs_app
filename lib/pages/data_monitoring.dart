
import 'package:burs_app/models/data_day_model.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../models/predict_day_model.dart';
import '../theme.dart';
import '../widgets/data_element.dart';

class DataMonitoring extends StatefulWidget{
  const DataMonitoring({super.key});

  @override
  State<StatefulWidget> createState() => _dataMonitoring();

}
class _dataMonitoring extends State<DataMonitoring>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.LIGHT,
      appBar: AppBar(
        title: const Text('data monitoring'),
        actions: [Padding(padding: const EdgeInsets.all(10),
          child: InkWell(child: const Icon(Icons.account_circle,size: 40,),onTap: (){},),)],
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            //const SizedBox(height: 50,),
            Padding(padding: EdgeInsets.all(30),
            child:
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),color: Colors.white,
                boxShadow: List<BoxShadow>.filled(1, const BoxShadow(color: Colors.grey,blurRadius: 10))
              ),
              child: //Padding(padding: const EdgeInsets.all(0),child:
              Stack(children: [
                Center(child:
                FractionallySizedBox(widthFactor: 1.27,
                child:
              SfCartesianChart(
                  // Initialize category axis
                    primaryXAxis: CategoryAxis(isVisible: false),
                    primaryYAxis: NumericAxis(isVisible: false),
                    borderColor: Colors.transparent,
                    backgroundColor: Colors.transparent,
                    plotAreaBackgroundColor: Colors.transparent,
                    plotAreaBorderColor: Colors.transparent,

                    // Chart title
                    title: ChartTitle(text: 'title',),
                    // Enable legend
                    legend: Legend(isVisible: true,position: LegendPosition.bottom),
                    // Enable tooltip
                    tooltipBehavior: TooltipBehavior(enable: true,),
                    series: <LineSeries<DataDayModel, String>>[
                      LineSeries<DataDayModel, String>(
                        color: ThemeColors.PRIMARY_DARK,
                        name: 'Main',
                        width: 10,

                        // Bind data source
                          dataSource:  <DataDayModel>[
                            DataDayModel(name: '2020.2.7', main: 50),
                            DataDayModel(name: '2020.2.6', main: 40),
                            DataDayModel(name: '2020.2.5', main: 45),
                            DataDayModel(name: '2020.2.4', main: 30),
                            DataDayModel(name: '2020.2.3', main: 22)
                          ],
                          xValueMapper: (DataDayModel model, _) => model.name,
                          yValueMapper: (DataDayModel model, _) => model.main
                      ),
                      LineSeries<DataDayModel, String>(
                        color: ThemeColors.PRIMARY,
                        width: 3,
                        name: '95^',

                        // Bind data source
                          dataSource:  <DataDayModel>[
                            DataDayModel(name: '2020.2.7', main: 60),
                            DataDayModel(name: '2020.2.6', main: 45),
                            DataDayModel(name: '2020.2.5', main: 60),
                            DataDayModel(name: '2020.2.4', main: 42),
                            DataDayModel(name: '2020.2.3', main: 27)
                          ],
                          xValueMapper: (DataDayModel model, _) => model.name,
                          yValueMapper: (DataDayModel model, _) => model.main
                      ),
                      LineSeries<DataDayModel, String>(
                          color: ThemeColors.PRIMARY,
                          width: 3,
                          name: '95⌄',

                        // Bind data source
                          dataSource:  <DataDayModel>[
                            DataDayModel(name: '2020.2.7', main: 40),
                            DataDayModel(name: '2020.2.6', main: 30),
                            DataDayModel(name: '2020.2.5', main: 32),
                            DataDayModel(name: '2020.2.4', main: 25),
                            DataDayModel(name: '2020.2.3', main: 10)
                          ],
                          xValueMapper: (DataDayModel model, _) => model.name,
                          yValueMapper: (DataDayModel model, _) => model.main
                      ),
                      LineSeries<DataDayModel, String>(
                          color: Colors.red,
                          width: 1,
                          name: '80^',

                          // Bind data source
                          dataSource:  <DataDayModel>[
                            DataDayModel(name: '2020.2.7', main: 80),
                            DataDayModel(name: '2020.2.6', main: 63),
                            DataDayModel(name: '2020.2.5', main: 71),
                            DataDayModel(name: '2020.2.4', main: 55),
                            DataDayModel(name: '2020.2.3', main: 30)
                          ],
                          xValueMapper: (DataDayModel model, _) => model.name,
                          yValueMapper: (DataDayModel model, _) => model.main
                      ),
                      LineSeries<DataDayModel, String>(
                          color: Colors.red,
                          width: 1,
                          name: '80⌄',

                          // Bind data source
                          dataSource:  <DataDayModel>[
                            DataDayModel(name: '2020.2.7', main: 30),
                            DataDayModel(name: '2020.2.6', main: 24),
                            DataDayModel(name: '2020.2.5', main: 26),
                            DataDayModel(name: '2020.2.4', main: 18),
                            DataDayModel(name: '2020.2.3', main: 5)
                          ],
                          xValueMapper: (DataDayModel model, _) => model.name,
                          yValueMapper: (DataDayModel model, _) => model.main
                      )
                      ,
                    ]
                ),))])
              //),
            )),
            DataElement(model: PredictDayModel(main : 50,name: '2020.2.7', max95: 60, min95: 40, max80: 80, min80: 30)),
            DataElement(model: PredictDayModel(main : 40,name: '2020.2.6', max95: 45, min95: 30, max80: 63, min80: 24)),
            DataElement(model: PredictDayModel(main : 45,name: '2020.2.5', max95: 60, min95: 32, max80: 71, min80: 26)),
            DataElement(model: PredictDayModel(main : 30,name: '2020.2.4', max95: 42, min95: 25, max80: 55, min80: 18)),
            DataElement(model: PredictDayModel(main : 22,name: '2020.2.3', max95: 27, min95: 10, max80: 30, min80: 5)),
            DataElement(model: DataDayModel(main : 12,name: '2020.2.2')),
            DataElement(model: DataDayModel(main : 15,name: '2020.2.1')),
            DataElement(model: DataDayModel(main : 14,name: '2020.1.30')),
            DataElement(model: DataDayModel(main : 20,name: '2020.1.29')),
            DataElement(model: DataDayModel(main : 17,name: '2020.1.28')),




          ],
        ),
      ),
    );
  }

}