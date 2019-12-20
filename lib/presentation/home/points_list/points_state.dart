import 'package:flutter_workshop/domain/model/point.dart';

abstract class PointsState {}

class Loading extends PointsState {}

class Points extends PointsState {
  final List<Point> points;

  Points(this.points);
}
