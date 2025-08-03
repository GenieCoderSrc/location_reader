import 'package:flutter/foundation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';

import 'i_location_services/i_geo_fire_point_converter.dart';
import 'i_location_services/i_location_service_geo_fire_point_provider.dart';
import 'i_location_services/i_location_service_geo_locator_provider.dart';

class LocationServiceGeoFirePointProviderImpl
    extends ILocationServiceGeoFirePointProvider {
  final ILocationServiceGeoLocatorProvider iLocationServiceGeoLocatorProvider;
  final IGeoFirePointConverter iGeoFirePointConverter;

  LocationServiceGeoFirePointProviderImpl({
    required this.iLocationServiceGeoLocatorProvider,
    required this.iGeoFirePointConverter,
  });

  @override
  Future<GeoFirePoint?> getCurrentLocation() async {
    try {
      final Position? currentLocation =
          await iLocationServiceGeoLocatorProvider.getCurrentLocation();

      return iGeoFirePointConverter.getGeoFirePoint(currentLocation);
    } catch (e) {
      debugPrint('LocationServiceRepository | getCurrentLocation | error: $e');
      return null;
    }
  }

  @override
  Future<GeoFirePoint?> getLastKnownPositionOrCurrentPosition() async {
    try {
      final Position? currentLocation =
          await iLocationServiceGeoLocatorProvider.getLastKnownPosition() ??
          await iLocationServiceGeoLocatorProvider.getCurrentLocation();

      return iGeoFirePointConverter.getGeoFirePoint(currentLocation);
    } catch (e) {
      return null;
    }
  }
}
