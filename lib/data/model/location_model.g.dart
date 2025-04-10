// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationModel _$LocationModelFromJson(Map<String, dynamic> json) =>
    LocationModel(
      lat: (json['lat'] as num?)?.toDouble(),
      lon: (json['lon'] as num?)?.toDouble(),
      geofPoint: JsonGeoFirePointConverterUtils.fromJson(
          json['geofPoint'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$LocationModelToJson(LocationModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('lat', instance.lat);
  writeNotNull('lon', instance.lon);
  val['geofPoint'] = JsonGeoFirePointConverterUtils.toJson(instance.geofPoint);
  return val;
}