import 'package:geolocator/geolocator.dart';

abstract class ILocationServiceGeoLocatorProvider {
  Future<Position?> getCurrentLocation({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    bool forceAndroidLocationManager = false,
    Duration? timeLimit,
  });

  Future<Position?> getLastKnownPosition({
    bool forceAndroidLocationManager = false,
  });
}
