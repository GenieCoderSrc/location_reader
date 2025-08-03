import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';

import 'i_location_services/i_geo_fire_point_converter.dart';

class GeoFirePointConverterImpl extends IGeoFirePointConverter {
  @override
  GeoFirePoint? getGeoFirePoint(final Position? position) {
    try {
      if (position != null) {
        // Create a GeoFirePoint from position (latitude, longitude)
        return GeoFirePoint(GeoPoint(position.latitude, position.longitude));
      }
      return null;
    } catch (e) {
      debugPrint('GeoFirePointConverterImpl | getGeoFirePoint | error: $e');
      return null;
    }
  }

  @override
  GeoFirePoint getLocationCenter({required double lat, required double lon}) {
    return GeoFirePoint(GeoPoint(lat, lon));
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';
// import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
// import 'package:geolocator/geolocator.dart';
//
// import 'i_location_services/i_geo_fire_point_converter.dart';
//
// class GeoFirePointConverterImpl extends IGeoFirePointConverter {
//   final GeoFlutterFire _geoFlutterFire;
//
//   GeoFirePointConverterImpl({GeoFlutterFire? geoFlutterFire})
//       : _geoFlutterFire = geoFlutterFire ?? GeoFlutterFire();
//
//   @override
//   GeoFirePoint? getGeoFirePoint(final Position? position) {
//     try {
//       if (position != null) {
//         return _geoFlutterFire.point(
//             latitude: position.latitude, longitude: position.longitude);
//       }
//       return null;
//     } catch (e) {
//       debugPrint('GeoFirePointConverterImpl | getGeoFirePoint | error: $e');
//       return null;
//     }
//   }
//
//   @override
//   GeoFirePoint getLocationCenter({required double lat, required double lon}) {
//     return _geoFlutterFire.point(latitude: lat, longitude: lon);
//   }
// }
