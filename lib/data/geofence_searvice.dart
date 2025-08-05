// import 'dart:async';

// import 'package:easy_geofencing/easy_geofencing.dart';
// import 'package:easy_geofencing/enums/geofence_status.dart';
// import 'package:geolocator/geolocator.dart';
//
// class GeofenceService {
//   static GeofenceService? _instance;
//
//   GeofenceService._();
//
//   static GeofenceService get getInstance => _instance ??= GeofenceService._();
//
//   bool isReady = false;
//   Position? position;
//   StreamSubscription<GeofenceStatus>? geofenceStatusStream;
//   Geolocator geolocator = Geolocator();
//   String geofenceStatus = '';
//
//   getCurrentPosition() async {
//     position = await Geolocator.getCurrentPosition(
//         desiredAccuracy: LocationAccuracy.best);
//     print("LOCATION => ${position!.toJson()}");
//     isReady = (position != null) ? true : false;
//   }
//
//   stopGeofence() {
//     print("stop");
//     EasyGeofencing.stopGeofenceService();
//     geofenceStatusStream!.cancel();
//   }
//
//   startGeoFencing({
//     double radiusMeter = 1.0,
//     int eventPeriodInSeconds = 600,
//     double? lat,
//     double? lon,
//   }) async {
//     // get current location
//     if (lat == null || lon == null) {
//       await getCurrentPosition();
//     }
//
//     // start geofence service
//     print("starting geoFencing Service");
//     EasyGeofencing.startGeofenceService(
//         pointedLatitude: lat?.toString() ?? position?.latitude.toString(),
//         pointedLongitude: lon?.toString() ?? position?.longitude.toString(),
//         radiusMeter: radiusMeter.toString(),
//         eventPeriodInSeconds: eventPeriodInSeconds);
//
//     checkGeofenceStream();
//   }
//
//   checkGeofenceStream() {
//     geofenceStatusStream ??=
//         EasyGeofencing.getGeofenceStream()?.listen((GeofenceStatus status) {
//       print(status.toString());
//       geofenceStatus = status.toString();
//     });
//   }
// }

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:geoflutterfire_plus/geoflutterfire_plus.dart';
import 'package:geolocator/geolocator.dart';

class GeofenceService {
  static GeofenceService? _instance;

  GeofenceService._();

  static GeofenceService get getInstance => _instance ??= GeofenceService._();

  bool isReady = false;
  Position? position;
  StreamSubscription<void>? geofenceStatusStream;
  String geofenceStatus = '';

  /// Get the current position of the device
  Future<void> getCurrentPosition() async {
    position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
    debugPrint("LOCATION => ${position!.toJson()}");
    isReady = position != null;
  }

  /// Stop the geofencing service
  void stopGeofence() {
    debugPrint("Stopping geofence service.");
    geofenceStatusStream?.cancel();
    geofenceStatusStream = null; // Clear the subscription
  }

  /// Start the geofencing service
  Future<void> startGeoFencing({
    required double radiusMeter,
    required int eventPeriodInSeconds,
    double? lat,
    double? lon,
  }) async {
    // Get current location if lat/lon are not provided
    if (lat == null || lon == null) {
      await getCurrentPosition();
    }

    // Create a GeoFirePoint from the current or provided coordinates
    GeoFirePoint center = GeoFirePoint(
      GeoPoint(lat ?? position!.latitude, lon ?? position!.longitude),
    );

    // Reference to Firestore collection where geofences will be stored
    CollectionReference<Map<String, dynamic>> collectionReference =
        FirebaseFirestore.instance.collection('geofences');

    // Adding geofence data to Firestore
    await collectionReference.add({
      'position': center.data, // Store the geofence center
      'radius': radiusMeter, // Store the geofence radius
      'createdAt': FieldValue.serverTimestamp(), // Store the creation time
    });

    // Check geofence status stream
    checkGeofenceStream(center, radiusMeter);
  }

  /// Check the stream of geofence status updates
  void checkGeofenceStream(GeoFirePoint center, double radius) {
    geofenceStatusStream = Stream.periodic(Duration(seconds: 5)).listen((
      _,
    ) async {
      if (position != null) {
        double distanceInMeters = Geolocator.distanceBetween(
          position!.latitude,
          position!.longitude,
          center.latitude,
          center.longitude,
        );

        // Update geofence status based on distance
        geofenceStatus = (distanceInMeters <= radius)
            ? "Inside Geofence"
            : "Outside Geofence";

        debugPrint("Geofence Status: $geofenceStatus");
      }
    });
  }
}
