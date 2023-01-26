import 'package:flutter/material.dart';

class RadioDialog extends StatefulWidget{
  int? selectedRadio = 0;
  final List<String> data ;
  final Function(int)? onFinished;

  RadioDialog({super.key,required this.data, this.onFinished,this.selectedRadio});
  @override
  State<StatefulWidget> createState() => _radioDialog();
  
}
class _radioDialog extends State<RadioDialog>{
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: List<Widget>.generate(widget.data.length, (int index) {
              return Row(
                children: [
                Radio<int>(

                value: index,
                groupValue: widget.selectedRadio,
                onChanged: (int? value) {
                  if(value != null) {
                    setState(() => widget.selectedRadio = value);
                    if(widget.onFinished != null) {
                      widget.onFinished!(value);
                    }
                  }
                },
              ),
                  Text(widget.data[index])
                ],
              );
            }),
          );
        },
      ),
    );
  }
  
}