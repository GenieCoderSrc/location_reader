abstract class ILocationCrudService {
  Future<bool> updateLocation(
      {required String id, required String path, String field = "position"});
}
