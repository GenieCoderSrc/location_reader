import 'package:geocoding/geocoding.dart';

abstract class IAddressService {
  Future<Placemark?> getAddress({required double lat, required double lon});
}
