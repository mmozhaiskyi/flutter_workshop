import 'package:flutter_workshop/domain/model/point.dart';
import 'package:json_annotation/json_annotation.dart';

import 'location_api_model.dart';

part 'point_api_model.g.dart';

@JsonSerializable()
class PointApiModel {
  final String id;
  final String name;
  final LocationApiModel location;

  PointApiModel(this.id, this.name, this.location);

  factory PointApiModel.fromJson(json) => _$PointApiModelFromJson(json);
  
  Point toModel() => Point(id, name, location.toModel(), location.address, location.distance);
}
