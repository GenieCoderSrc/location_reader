import 'package:geo_lat_lon/geo_lat_lon.dart';

abstract class ILocationServiceGeoFirePointProvider {
  Future<GeoFirePoint?> getCurrentLocation();

  Future<GeoFirePoint?> getLastKnownPositionOrCurrentPosition();
}
