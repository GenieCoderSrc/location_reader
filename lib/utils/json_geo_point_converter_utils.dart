import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class GeoPointUtils {
  static GeoFirePoint? fromJsonGeoPoint(Map<String, dynamic> json) =>
      json['geopoint'] == null ? null : json['geopoint'] as GeoFirePoint?;

  static Map<String, dynamic>? toJsonGeoData(GeoFirePoint? geoPoint) =>
      geoPoint?.data;

  static Map<String, dynamic> toJsonGeoPoint(GeoFirePoint? geoPoint) =>
      <String, dynamic>{
        "data": geoPoint?.data,
        "latitude": geoPoint?.latitude,
        "longitude": geoPoint?.longitude
      };
}