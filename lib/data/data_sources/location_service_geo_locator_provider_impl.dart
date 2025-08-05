import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';

import 'i_location_services/i_location_permission_manager.dart';
import 'i_location_services/i_location_service_geo_locator_provider.dart';

class LocationServiceGeoLocatorProviderImpl
    extends ILocationServiceGeoLocatorProvider {
  final ILocationPermissionManager iLocationPermissionManager;

  LocationServiceGeoLocatorProviderImpl({
    required this.iLocationPermissionManager,
  });

  @override
  Future<Position?> getCurrentLocation({
    LocationAccuracy desiredAccuracy = LocationAccuracy.best,
    bool forceAndroidLocationManager = false,
    Duration? timeLimit,
  }) async {
    try {
      bool serviceEnabled = await iLocationPermissionManager
          .checkLocationPermission();

      if (serviceEnabled) {
        return await Geolocator.getCurrentPosition(
          desiredAccuracy: desiredAccuracy,
          forceAndroidLocationManager: forceAndroidLocationManager,
          timeLimit: timeLimit,
        );
      }
      return getLastKnownPosition();
    } catch (e) {
      debugPrint('_determinePosition | error: $e');
      // appToast(msg: translateTxtWithoutContext(failed_to_get_location));
      return getLastKnownPosition();
    }
  }

  @override
  Future<Position?> getLastKnownPosition({
    bool forceAndroidLocationManager = true,
  }) async {
    try {
      return await Geolocator.getLastKnownPosition(
        forceAndroidLocationManager: forceAndroidLocationManager,
      );
    } catch (e) {
      return null;
    }
  }
}
