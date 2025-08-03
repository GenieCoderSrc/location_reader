import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/utils/convert_geo_fire_point.dart';

part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocationModel extends LocationEntity {
  @JsonKey(
    fromJson: JsonGeoFirePointConverterUtils.fromJson,
    toJson: JsonGeoFirePointConverterUtils.toJson,
  )
  final GeoFirePoint? geofPoint;

  LocationModel({double? lat, double? lon, this.geofPoint})
    : super(lat: geofPoint?.latitude ?? lat, lon: geofPoint?.longitude ?? lon);

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    double? lat = (json['lat'] as num?)?.toDouble();
    double? lon = (json['lon'] as num?)?.toDouble();

    debugPrint('LocationModel | fromJson | lat: $lat lon: $lon');

    // geofPoint value taken from DB
    if (lat == null || lon == null) {
      return _$LocationModelFromJson(json);
    }

    // lat, lon value taken from entity
    return LocationModel(geofPoint: GeoFirePoint(GeoPoint(lat, lon)));
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = _$LocationModelToJson(this);
    // Exclude the field during serialization
    data.remove('lat');
    data.remove('lon');
    return data;
  }

  @override
  List<Object?> get props => [geofPoint];
}
