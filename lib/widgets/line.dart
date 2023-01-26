import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Line extends StatelessWidget{

  final Color? color;
  final double? width;
  final double? height;
  final double? borderRadios;

  const Line({Key? key,this.color,this.height,this.width,this.borderRadios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? MediaQuery.of(context).size.height,
      height: height ?? 2,
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(borderRadios ?? 0)),
            color: color ?? Colors.black,
          )),
    );
  }

}