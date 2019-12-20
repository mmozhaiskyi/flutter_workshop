import 'package:flutter_workshop/domain/model/point.dart';

abstract class PointsEvent {}

class PointFavSelected extends PointsEvent {
  final Point point;

  PointFavSelected(this.point);
}

class PointsContent extends PointsEvent {
  final List<Point> points;

  PointsContent(this.points);
}
