abstract class ILocationPermissionManager {
  Future<bool> requestLocationPermission();

  Future<bool> checkLocationPermission();
}
