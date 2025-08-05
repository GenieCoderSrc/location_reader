import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

import 'i_location_services/i_city_name_service.dart';

class CityNameServiceImpl extends ICityNameService {
  @override
  Future<String?> getCityName({
    required double lat,
    required double lon,
  }) async {
    try {
      final Placemark placeMark = (await placemarkFromCoordinates(
        lat,
        lon,
      )).first;

      final String name = placeMark.name ?? '';
      final String subLocality = placeMark.subLocality?.trim() ?? '';
      final String locality = placeMark.locality?.trim() ?? '';
      final String administrativeArea = placeMark.administrativeArea ?? '';
      final String postalCode = placeMark.postalCode ?? '';
      final String isoCountryCode = placeMark.isoCountryCode ?? '';
      final String country = placeMark.country ?? '';

      final String address =
          "$name, $subLocality, $locality, $administrativeArea "
          "postalCode: $postalCode, isoCountryCode: $isoCountryCode $country";
      debugPrint('CityNameServiceImpl | getCityName | address : $address');

      final List<String> locationParts = [
        subLocality,
        locality,
        administrativeArea,
        country,
      ];

      final String cityName = locationParts.firstWhere(
        (part) => part.isNotEmpty,
        orElse: () => address,
      );

      debugPrint('CityNameServiceImpl | getCityName | cityName: $cityName');
      return cityName;
    } catch (e) {
      debugPrint('CityNameServiceImpl | getCityName | error: $e');
      return null;
    }
    return null;
  }
}
