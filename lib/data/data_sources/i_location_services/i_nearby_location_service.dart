import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';

abstract class INearbyLocationService {
  Stream<List<Object?>>? findNearByLocation({
    required Query<Map<String, dynamic>> ref,
    double radius = 50,
    required GeoFirePoint center,
    String positionField = "position",
    bool strictMode = false,
  });
}
