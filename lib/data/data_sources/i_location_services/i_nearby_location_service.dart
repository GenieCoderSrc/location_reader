import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_lat_lon/geo_lat_lon.dart';

abstract class INearbyLocationService {
  Stream<List<Object?>>? findNearByLocation({
    required Query<Map<String, dynamic>> ref,
    double radius = 50,
    required GeoFirePoint center,
    String positionField = "position",
    bool strictMode = false,
  });
}
