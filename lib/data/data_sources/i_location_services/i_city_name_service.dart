abstract class ICityNameService {
  Future<String?> getCityName({required double lat, required double lon});
}
