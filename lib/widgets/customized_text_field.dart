
import 'package:flutter/material.dart';
import 'package:masked_text_field/masked_text_field.dart';

import '../theme.dart';

class CustomizedTextField extends StatelessWidget{
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
  Widget build(BuildContext context) => Padding(padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 20),
    child: MaskedTextField
      (
      mask: mask ?? '',
      maxLength: max ?? 50,
      keyboardType: type,
      autofocus: false,
      inputDecoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
          hintStyle: TextStyle(fontWeight: FontWeight.bold),
          floatingLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          helperText: helper,
          hintText: hint,

          focusColor: ThemeColors.PRIMARY_LIGHT,
          fillColor: ThemeColors.PRIMARY_LIGHT,
          hoverColor: ThemeColors.PRIMARY_DARK
      ),
      textStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
      textFieldController: c,
      onChange: (String value) {  },
    ),
  );

}