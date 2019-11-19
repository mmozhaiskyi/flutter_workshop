// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'point_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointApiModel _$PointApiModelFromJson(Map<String, dynamic> json) {
  return PointApiModel(
    json['id'] as String,
    json['name'] as String,
    json['location'] == null
        ? null
        : LocationApiModel.fromJson(json['location']),
  );
}

Map<String, dynamic> _$PointApiModelToJson(PointApiModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
    };
