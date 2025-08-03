import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

class JsonGeoFirePointConverterUtils {
  static GeoFirePoint? fromJsonGeoPoint(GeoFirePoint? geoPoint) => geoPoint;

  static GeoFirePoint? fromJson(Map<String, dynamic>? json) {
    GeoPoint? geoPoint = getGeoPoint(json);

    if (geoPoint != null) {
      return GeoFirePoint(GeoPoint(geoPoint.latitude, geoPoint.longitude));
    }
    return null;
  }

  static GeoPoint? getGeoPoint(Map<String, dynamic>? json) =>
      json?['geopoint'] as GeoPoint?;

  static Map<String, dynamic>? toJson(GeoFirePoint? geoFirePoint) =>
      geoFirePoint?.data;
}
