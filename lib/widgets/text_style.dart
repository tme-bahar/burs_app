import 'package:flutter/cupertino.dart';

import '../theme.dart';

class SpecialTextStyle extends TextStyle{
  SpecialTextStyle({double? size,Color? color}):super(color: color ?? ThemeColors.PRIMARY_DARK,fontSize: size ?? 15,
      fontWeight: FontWeight.bold);
}