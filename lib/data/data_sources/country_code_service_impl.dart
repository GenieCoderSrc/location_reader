import 'package:flutter/foundation.dart';
import 'package:geocoding/geocoding.dart';

import 'i_location_services/i_country_code_service.dart';

class CountryCodeServiceImpl extends ICountryCodeService {
  @override
  Future<String?> getCountryCode({
    required double lat,
    required double lon,
  }) async {
    try {
      return (await placemarkFromCoordinates(lat, lon)).first.isoCountryCode;
    } catch (e) {
      debugPrint('CountryCodeServiceImpl | getCountryCode | error: $e');
      return null;
    }
  }
}
