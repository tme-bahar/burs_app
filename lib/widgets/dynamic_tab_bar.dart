import 'package:burs_app/widgets/text_style.dart';
import 'package:flutter/material.dart';

import '../theme.dart';
import 'dynamic_tab_element.dart';

class DynamicTabBar extends StatefulWidget{
  final List<String> data;
  int? selected;
  final Color? back;
  final Color? front;
  final Function(int)? onItemClick;
  final VoidCallback? onAddClick;
  final String? addText;

  DynamicTabBar({super.key, required this.data,this.selected, this.back, this.front, this.onItemClick, this.onAddClick, this.addText});

  @override
  State<StatefulWidget> createState() => _dynamicTabBar();
}
class _dynamicTabBar extends State<DynamicTabBar>{
  @override
  Widget build(BuildContext context) => ListView(

    scrollDirection: Axis.horizontal,
    children: children(),
  );

  List<Widget> children(){
    List<Widget> result = List.empty(growable: true);
    for(int i = 0 ; i < widget.data.length; i++) {
      result.add(DynamicTabElement(text: widget.data[i],
        selected: (widget.selected ?? 0) == i,
        index: i,
        back: widget.back,
        front: widget.front,
        onClick: (i){
          if(widget.onItemClick != null) {
            widget.onItemClick!(i);
          }
          setState(() {
            widget.selected = i;
          });
        },
      ));
    }
    result.add(addButton(widget.onAddClick,widget.addText),);
    return result;
  }

  Widget addButton(VoidCallback? onClick,[String? text])=>Padding(padding: const EdgeInsets.only(top : 15,left: 5,right: 5,bottom: 10),
    child: InkWell(
      onTap: onClick,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(40)),
              color: ThemeColors.PRIMARY_LIGHT,
              border: Border.all(color:ThemeColors.PRIMARY_DARK,width: 3),
              boxShadow: const [
                BoxShadow(color: Colors.grey,blurRadius: 15)
              ]
          ),
          child: Center(
            child: Text(text ?? '+ افزودن',style:
            SpecialTextStyle(size: 18,color:ThemeColors.PRIMARY_DARK),),
          )
      ),
    ),
  );

}