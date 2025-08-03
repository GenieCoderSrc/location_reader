import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_locator_provider.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/i_repository/i_current_location_repository.dart';

class CurrentLocationRepositoryImpl extends ICurrentLocationRepository {
  final ILocationServiceGeoLocatorProvider iLocationServiceGeoLocatorProvider;

  CurrentLocationRepositoryImpl({
    required this.iLocationServiceGeoLocatorProvider,
  });

  @override
  Future<Either<IFailure, LocationEntity>> getCurrentLocation() async {
    try {
      Position? position =
          await iLocationServiceGeoLocatorProvider.getCurrentLocation();
      if (position != null) {
        return Right(
          LocationEntity(lat: position.latitude, lon: position.longitude),
        );
      }
      return const Left(LocationError(LocationErrorType.permissionDenied));
    } catch (e) {
      return const Left(LocationError(LocationErrorType.permissionDenied));
    }
  }
}
