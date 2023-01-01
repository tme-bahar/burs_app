import 'package:burs_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeListElement extends StatefulWidget{
  final double? width;
  final double? height;
  final Widget? circleChild;
  final Function(int)? onTap;
  final int? index;
  final String? title;
  final String? subTitle;

  const HomeListElement({
  super.key,
  this.width,
  this.height,
  this.circleChild,
  this.onTap,
  this.index,
  this.title,
  this.subTitle
  });
  @override
  State<StatefulWidget> createState() => _homeListElement();

}
class _homeListElement extends State<HomeListElement>{
  static const double circleHorizontalPadding = 15;
  static const double circleVerticalPadding = 7;
  static const double height = 65;
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: ()=> widget.onTap != null ? widget.onTap!(widget.index ?? 0) : (){},
        child:Container(color: ThemeColors.LIGHT
          ,width: widget.width ?? MediaQuery.of(context).size.width
          ,height: widget.height ?? height + 2,
          child:
          Column(children: [
            Row(
              children: [
                Padding(padding: const EdgeInsets.symmetric(
                    horizontal: circleHorizontalPadding,
                    vertical: circleVerticalPadding
                ),
                  child: Container(
                    height: (widget.height ?? height) - 2*circleVerticalPadding,
                    width: (widget.height ?? height) - 2*circleVerticalPadding,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: ThemeColors.PRIMARY_LIGHT
                    ),
                    child: widget.circleChild ?? const Icon(Icons.help_outline),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    co(Text(widget.title ?? '',
                      style: const TextStyle(color: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 20),),
                    ),
                    if(widget.subTitle != null)
                      co(Text(widget.subTitle ?? '',
                              style: const TextStyle(color: ThemeColors.PRIMARY_DARK,fontSize: 10),)
                      )
                ],),

              ],
          ),
            Container(
              height: 2,
              width: widget.width ?? MediaQuery.of(context).size.width,
              color: const Color(0xffa0a0a0),
            )
          ])
        )
    );
  }
  SizedBox co(Widget child){
    return SizedBox(
      width: (widget.width ?? MediaQuery.of(context).size.width)
          - 2*circleVerticalPadding - circleHorizontalPadding - 65,
      child: Row(mainAxisAlignment: MainAxisAlignment.start,
        children: [
          child
        ],
      ),
    );
  }
}
