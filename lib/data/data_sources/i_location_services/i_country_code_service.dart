abstract class ICountryCodeService {
  Future<String?> getCountryCode({required double lat, required double lon});
}
