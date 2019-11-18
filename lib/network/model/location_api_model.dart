import 'package:flutter_workshop/domain/model/point.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_api_model.g.dart';

@JsonSerializable()
class LocationApiModel {
  final double lat;
  final double lng;
  final String address;

  LocationApiModel(this.lat, this.lng, this.address);

  factory LocationApiModel.fromJson(json) => _$LocationApiModelFromJson(json);

  @override
  String toString() => '$lat,$lng';

  Location toModel() => Location(lat, lng);
}
