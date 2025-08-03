import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';

abstract class IGeoFirePointConverter {
  GeoFirePoint? getGeoFirePoint(Position? position);

  GeoFirePoint getLocationCenter({required double lat, required double lon});
}
