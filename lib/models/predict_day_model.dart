import 'package:burs_app/models/data_day_model.dart';

class PredictDayModel extends DataDayModel{
  final int max95;
  final int min95;
  final int max80;
  final int min80;
  PredictDayModel(
      {required super.main,
        required this.max95,
        required this.min95,
        required this.max80,
        required this.min80,
        required super.name});
}