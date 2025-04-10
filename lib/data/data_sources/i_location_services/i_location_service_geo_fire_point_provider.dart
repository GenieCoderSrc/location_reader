import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

abstract class ILocationServiceGeoFirePointProvider {
  Future<GeoFirePoint?> getCurrentLocation();

  Future<GeoFirePoint?> getLastKnownPositionOrCurrentPosition();
}