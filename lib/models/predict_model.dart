import 'package:burs_app/models/data_day_model.dart';
import 'package:burs_app/models/predict_day_model.dart';

class PredictModel{
  final String name;
  final String? description;
  final int index;
  final int L1i;
  final int L2i;
  final int c;
  final int p;
  final int t;
  final String filePath;
  final List<DataDayModel> data;
  PredictModel(this.data,{required this.filePath,required this.name,this.description,required this.index,
    required this.L1i, required this.L2i, required this.c, required this.p, required this.t, });
}