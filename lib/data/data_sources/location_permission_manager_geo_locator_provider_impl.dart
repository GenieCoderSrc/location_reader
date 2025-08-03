import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

import 'i_location_services/i_location_permission_manager.dart';

class LocationPermissionManagerGeolocatorProviderImpl
    implements ILocationPermissionManager {
  @override
  Future<bool> requestLocationPermission() async {
    try {
      Fluttertoast.showToast(msg: "Please! Enable GPS Service");
      LocationPermission permission = await Geolocator.requestPermission();

      return permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse;
    } catch (e) {
      // Handle error
      debugPrint(
        'GeoLocatorPermissionManager | requestLocationPermission | Error handling location permission: $e',
      );
      return false;
    }
  }

  @override
  Future<bool> checkLocationPermission() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.deniedForever) {
        // If permission is denied forever, open app settings
        await Geolocator.openAppSettings();
        return false;
      }
      // Permission is already granted, no need to request again.
      if (permission == LocationPermission.always ||
          permission == LocationPermission.whileInUse) {
        return true;
      } else {
        // Request permission if not granted
        return requestLocationPermission();
      }
    } catch (e) {
      // Handle error
      debugPrint(
        'GeoLocatorPermissionManager | checkLocationPermission | Error checking location permission: $e',
      );
      return false;
    }
  }
}
