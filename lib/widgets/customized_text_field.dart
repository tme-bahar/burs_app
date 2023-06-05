
import 'package:flutter/material.dart';
import 'package:masked_text_field/masked_text_field.dart';

import '../theme.dart';

class CustomizedTextField extends StatefulWidget{
  final String label;
  final String hint;
  final String? helper;
  final TextEditingController c;
  final TextInputType type;
  final int? max;
  final String? mask;

  const CustomizedTextField({super.key,
    required this.label,
    required this.hint,
    this.helper,
    required this.c,
    required this.type,
    this.max,
    this.mask
  });
  @override
  State<StatefulWidget> createState() => _customizedTextField();

}
class _customizedTextField extends State<CustomizedTextField>{


  _customizedTextField();

  @override
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
    child: Stack(
      children: [
        MaskedTextField
        (
          mask: widget.mask ?? '',
          maxLength: widget.max ?? 50,
          keyboardType: widget.type,
          autofocus: false,
          inputDecoration: InputDecoration(
              labelText: widget.label,
              labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
              hintStyle: TextStyle(fontWeight: FontWeight.bold),
              floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
              helperText: widget.helper,
              hintText: widget.hint,

              focusColor: ThemeColors.PRIMARY_LIGHT,
              fillColor: ThemeColors.PRIMARY_LIGHT,
              hoverColor: ThemeColors.PRIMARY_DARK
          ),
          //textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          textFieldController: widget.c,
          onChange: (String value) {  },

        ),
        if(widget.c.text.isNotEmpty)
          Align(alignment: Alignment.centerLeft,
            child: FloatingActionButton.small(
              heroTag: 'duplicate ${widget.label}',
              onPressed: ()=>setState(() =>widget.c.text=''),
              child: Icon(Icons.delete_forever,color: Colors.red),
              backgroundColor: ThemeColors.LIGHT,
              elevation: 1,
            ),
          )

      ],
      ));

}