// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:geoflutterfire2/geoflutterfire2.dart';
//
// // import 'package:geoflutterfire/src/point.dart';
//
// import 'i_location_services/i_nearby_location_service.dart';
//
// class NearbyLocationGeofireServiceImpl extends INearbyLocationService {
//   final GeoFlutterFire _geoflutterfire;
//
//   NearbyLocationGeofireServiceImpl({GeoFlutterFire? geoflutterfire})
//       : _geoflutterfire = geoflutterfire ?? GeoFlutterFire();
//
//   @override
//   Stream<List<Object?>>? findNearByLocation({
//     required Query<Map<String, dynamic>> ref,
//     required GeoFirePoint center,
//     double radius = 50,
//     positionField = 'position',
//     strictMode,
//   }) {
//     // query nearby location
//     return _geoflutterfire
//         .collection(collectionRef: ref)
//         .within(
//             center: center,
//             radius: radius,
//             field: positionField,
//             strictMode: strictMode ?? radius > 10)
//         .map((List<DocumentSnapshot<Object?>> event) =>
//             event.map((DocumentSnapshot<Object?> doc) => doc.data()).toList());
//   }
// }

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geo_lat_lon/geo_lat_lon.dart';

import 'i_location_services/i_nearby_location_service.dart';

class NearbyLocationService implements INearbyLocationService {
  @override
  Stream<List<Object?>>? findNearByLocation({
    required Query<Map<String, dynamic>> ref,
    double radius = 50,
    required GeoFirePoint center,
    String positionField = "position",
    bool strictMode = false,
  }) {
    // Create a GeoCollectionReference from the provided FireStore query's collection
    final CollectionReference<Map<String, dynamic>> collectionReference = ref
        .getCollection();

    // Function to get GeoPoint instance from Cloud Firestore document data
    GeoPoint geopointFrom(Map<String, dynamic> data) {
      return (data[positionField] as Map<String, dynamic>)['geopoint']
          as GeoPoint;
    }

    // Create a GeoCollectionReference
    GeoCollectionReference<Map<String, dynamic>> geoCollectionRef =
        GeoCollectionReference<Map<String, dynamic>>(collectionReference);

    // Stream of document snapshots of geo query under given conditions
    final Stream<List<DocumentSnapshot<Map<String, dynamic>>>> stream =
        geoCollectionRef.subscribeWithin(
          center: center,
          radiusInKm: radius,
          field: positionField,
          geopointFrom: geopointFrom,
        );

    // Transform the stream to return a list of maps
    return stream.map((snapshots) {
      return snapshots.map((doc) {
        var data = doc.data()!;
        return {
          ...data, // Spread the document's data
          'id': doc.id, // Add document ID to the map
        };
      }).toList();
    });
  }
}

// Extension method to get the CollectionReference from a Query
extension QueryExtensions<T> on Query<T> {
  CollectionReference<T> getCollection() {
    // Assuming that the Query was created from a CollectionReference
    if (this is Query<Map<String, dynamic>>) {
      return (this as dynamic).parent
          as CollectionReference<T>; // Use dynamic to bypass type checks
    }
    throw Exception('The provided query is not from a collection reference.');
  }
}
