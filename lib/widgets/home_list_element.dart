import 'package:burs_app/models/predict_model.dart';
import 'package:burs_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeListElement extends StatefulWidget{
  final double? width;
  final double? height;
  final Widget? circleChild;
  final Function(int,PredictModel?)? onTap;
  final int? index;
  final String? title;
  final String? subTitle;
  final PredictModel? pm;
  final Function(int,PredictModel?)? onDuplicateTap;
  final Function(int,PredictModel?)? onDeleteTap;

  const HomeListElement({
  super.key,
  this.width,
  this.height,
  this.circleChild,
  this.onTap,
  this.index,
  this.title,
  this.subTitle,
  this.pm,
  this.onDuplicateTap,
  this.onDeleteTap
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
      onTap: ()=> widget.onTap != null ? widget.onTap!(widget.index ?? 0,widget.pm) : (){},
        child:Container(color: ThemeColors.LIGHT
          ,width: widget.width ?? MediaQuery.of(context).size.width
          ,height: widget.height ?? height + 2,
          child:
          Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  child: Row(
                    children: [
                      Padding(padding: const EdgeInsets.symmetric(
                        vertical: circleVerticalPadding,
                        horizontal: circleHorizontalPadding,
                      ),
                        child: Container(
                          height: (widget.height ?? height) - 2*circleVerticalPadding,
                          width: (widget.height ?? height) - 2*circleVerticalPadding,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: widget.onTap != null ? ThemeColors.PRIMARY_LIGHT : Colors.yellow
                          ),
                          child: widget.circleChild ?? const Icon(Icons.help_outline),
                        ),
                      ),
                      Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(widget.title ?? '',
                              style: const TextStyle(color: ThemeColors.DARK,fontWeight: FontWeight.bold,fontSize: 20),),
                            if(widget.subTitle != null)
                              Text(widget.subTitle ?? '',
                                style: const TextStyle(color: ThemeColors.PRIMARY_DARK,fontSize: 10),)
                          ],),
                    ],
                  ),
                ),
                SizedBox(
                  child: Row(
                    children: [
                      if(widget.onDuplicateTap != null)
                        Padding(padding: const EdgeInsets.symmetric(
                          vertical: circleVerticalPadding,
                          horizontal: circleVerticalPadding,
                        ),
                          child: FloatingActionButton.small(
                            heroTag: 'duplicate ${widget.title}',
                            onPressed: ()=>widget.onDuplicateTap!(widget.index??0,widget.pm),
                            child: Icon(Icons.note_add_outlined,color: ThemeColors.PRIMARY_DARK),
                            backgroundColor: ThemeColors.LIGHT,
                            elevation: 1,
                          ),
                        ),
                      if(widget.onDeleteTap != null)
                        Padding(padding: const EdgeInsets.symmetric(
                          vertical: circleVerticalPadding,
                          horizontal: circleVerticalPadding,
                        ),
                          child: FloatingActionButton.small(
                            heroTag: 'delete ${widget.title}',
                            onPressed: ()=>widget.onDeleteTap!(widget.index??0,widget.pm),
                            child: Icon(Icons.delete_forever,color: Colors.red),
                            backgroundColor: ThemeColors.LIGHT,
                            elevation: 1,
                          ),
                        )
                    ],
                  ),
                )
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
}
