import 'package:burs_app/theme.dart';
import 'package:burs_app/widgets/special_button.dart';
import 'package:flutter/cupertino.dart';

import 'line.dart';

class DataLineChart extends StatefulWidget{
  final double main;
  final double max1;
  final double max2;
  final double min1;
  final double min2;
  final Color? colorMain;
  final Color? color1;
  final Color? color2;
  double xtapped = -1;

  DataLineChart({super.key,
  required this.main,
  required this.max1,
  required this.max2,
  required this.min1,
  required this.min2,
  this.colorMain,
  this.color1,
  this.color2});
  @override
  State<StatefulWidget> createState() => _dataLineChart();

}
class _dataLineChart extends State<DataLineChart>{

  @override
  Widget build(BuildContext context) {
    if(widget.xtapped == -1) {
      widget.xtapped = _mainPos();
    }
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 100,
      child: Stack(
        children: [
          Center(child: Line(height:10,width: MediaQuery.of(context).size.width-70,
              color: widget.color2??ThemeColors.PRIMARY_LIGHT,borderRadios: 5,),),
          Align(alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.only(left: _firstLeft()),
              child: Line(height:10,width: _firstLength(),
                  color: widget.color1??ThemeColors.PRIMARY,borderRadios: 5,),
            ),
          ),
          Align(alignment: Alignment.centerLeft,
            child: Padding(padding: EdgeInsets.only(left: _mainPos()),
              child: Line(height:10,width: 10,
                  color: widget.colorMain??ThemeColors.PRIMARY_DARK,borderRadios: 5,),
            ),
          ),
          Center(child:
            SizedBox(height:20,width: MediaQuery.of(context).size.width-70,
              child:
                GestureDetector(
                  onTapDown:(details){
                    setState(() {
                      widget.xtapped = details.localPosition.dx;
                      getActualValue();
                    });
                  }
                )
            ),
          ),
          Align(alignment: Alignment.topLeft,
            child: Padding(padding: EdgeInsets.only(left: widget.xtapped,top: 5),
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(6)),
                  color: ThemeColors.PRIMARY_LIGHT,
                ),
                child: Padding(padding: EdgeInsets.all(5),
                  child: Text(getActualValue().toString(),style: _style(),),)
              )
            ),
          )
        ],
      ),
    );
  }

  int getActualValue(){
    double delta = widget.max2 - widget.min2;
    //print((delta*widget.xtapped/(MediaQuery.of(context).size.width-70))+widget.min2);
    return ((delta*widget.xtapped/(MediaQuery.of(context).size.width-70))+widget.min2).toInt();
  }
  TextStyle _style([double? size,Color? color]) =>
      TextStyle(color: color ?? ThemeColors.PRIMARY_DARK,fontSize: size ?? 15,
          fontWeight: FontWeight.bold);

  double _firstLeft(){
    double delta = widget.max2 - widget.min2;
    double absolute = widget.min1 - widget.min2;
    double div = absolute/delta;
    double distance = (MediaQuery.of(context).size.width-70)*div;
    return distance;
  }
  double _firstLength(){
    double delta = widget.max2 - widget.min2;
    double absolute = widget.max1 - widget.min1;
    double div = absolute/delta;
    double distance = (MediaQuery.of(context).size.width-70)*div;
    return distance;
  }
  double _mainPos(){
    double delta = widget.max2 - widget.min2;
    double absolute = widget.main - widget.min2;
    double div = absolute/delta;
    double distance = (MediaQuery.of(context).size.width-70)*div;
    return distance;
  }
}