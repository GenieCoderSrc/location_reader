import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

import 'i_location_services/i_address_service.dart';

class AddressServiceImpl extends IAddressService {
  final Geocoding _geocoding = Geocoding();

  @override
  Future<Placemark?> getAddress({
    required double lat,
    required double lon,
  }) async {
    try {
      // Call placemarkFromCoordinates on the geocoding instance
      final Placemark placeMark = (await _geocoding.placemarkFromCoordinates(
        lat,
        lon,
      ))
          .first;

      debugPrint(
        'AddressServiceImpl | getAddress | address : ${placeMark.toString()}',
      );
      return placeMark;
    } catch (e) {
      debugPrint('AddressServiceImpl | getAddress | error: $e');
    }
    return null;
  }
}

// class AddressServiceImpl extends IAddressService {
//   @override
//   Future<Placemark?> getAddress({
//     required double lat,
//     required double lon,
//   }) async {
//     try {
//       final Placemark placeMark = (await placemarkFromCoordinates(
//         lat,
//         lon,
//       )).first;
//       debugPrint(
//         'AddressServiceImpl | getAddress | address : ${placeMark.toString()}',
//       );
//       return placeMark;
//     } catch (e) {
//       debugPrint('AddressServiceImpl | getAddress | error: $e');
//     }
//     return null;
//   }
// }
