import 'package:burs_app/models/data_day_model.dart';

class PredictDayModel extends DataDayModel{
  final double max95;
  final double min95;
  final double max80;
  final double min80;
  PredictDayModel(
      {required super.main,
        required super.index,
        required this.max95,
        required this.min95,
        required this.max80,
        required this.min80,
        required super.name}) ;
}