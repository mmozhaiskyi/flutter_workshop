import 'package:flutter_workshop/domain/model/point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_api_model.g.dart';

@JsonSerializable()
class LocationApiModel {
  final double lat;
  final double lng;
  final String address;
  final int distance;

  LocationApiModel(this.lat, this.lng, this.address, this.distance);

  factory LocationApiModel.fromJson(json) => _$LocationApiModelFromJson(json);

  @override
  String toString() => '$lat,$lng';

  Location toModel() => Location(lat, lng);
}
