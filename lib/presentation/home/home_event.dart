import 'package:flutter_workshop/domain/model/point.dart';

abstract class HomeEvent {}

class FetchPoints extends HomeEvent {}

class LocationChanged extends HomeEvent {
  final Location location;

  LocationChanged(this.location);
}
