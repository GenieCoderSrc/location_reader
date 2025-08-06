import 'package:geo_lat_lon/geo_lat_lon.dart';
import 'package:geolocator/geolocator.dart';

abstract class IGeoFirePointConverter {
  GeoFirePoint? getGeoFirePoint(Position? position);

  GeoFirePoint getLocationCenter({required double lat, required double lon});
}
