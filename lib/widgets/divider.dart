import 'package:flutter/cupertino.dart';

class ThickDivider extends StatelessWidget{
  final String? text;
  final double? height;
  final double? width;
  const ThickDivider({super.key,this.text,this.height,this.width});

  @override
  Widget build(BuildContext context) {
    const double height = 25;
    return Container(color: const Color(0xff808080)
    ,width: width ?? MediaQuery.of(context).size.width
    ,height: this.height ?? height + 2,
    child: Padding(padding: EdgeInsets.only(left: 5,right: 5),
      child: Row(children: [Text(text ?? '',)],),
    )
    );
  }

}