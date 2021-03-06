import 'package:flutter_workshop/domain/model/point.dart';

abstract class HomeState {}

class Loading extends HomeState {}

class Content extends HomeState {
  final List<Point> points;
  final Location userLocation;
  final int searchAreaRadius;

  Content(this.points, this.userLocation, this.searchAreaRadius);
}
