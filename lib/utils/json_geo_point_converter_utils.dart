import 'package:geo_lat_lon/geo_lat_lon.dart';

class GeoPointUtils {
  static GeoFirePoint? fromJsonGeoPoint(Map<String, dynamic> json) =>
      json['geopoint'] == null ? null : json['geopoint'] as GeoFirePoint?;

  static Map<String, dynamic>? toJsonGeoData(GeoFirePoint? geoPoint) =>
      geoPoint?.data;

  static Map<String, dynamic> toJsonGeoPoint(GeoFirePoint? geoPoint) =>
      <String, dynamic>{
        "data": geoPoint?.data,
        "latitude": geoPoint?.latitude,
        "longitude": geoPoint?.longitude,
      };
}
