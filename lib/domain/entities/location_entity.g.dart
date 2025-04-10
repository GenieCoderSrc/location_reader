// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationEntity _$LocationEntityFromJson(Map<String, dynamic> json) =>
    LocationEntity(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationEntityToJson(LocationEntity instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lat', instance.lat);
  writeNotNull('lon', instance.lon);
  return val;
}
