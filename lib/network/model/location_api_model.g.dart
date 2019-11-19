// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationApiModel _$LocationApiModelFromJson(Map<String, dynamic> json) {
  return LocationApiModel(
    (json['lat'] as num)?.toDouble(),
    (json['lng'] as num)?.toDouble(),
    json['address'] as String,
  );
}

Map<String, dynamic> _$LocationApiModelToJson(LocationApiModel instance) =>
    <String, dynamic>{
      'lat': instance.lat,
      'lng': instance.lng,
      'address': instance.address,
    };
