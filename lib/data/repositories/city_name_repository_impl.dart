import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_city_name_service.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_locator_provider.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/i_repository/i_city_name_repository.dart';

class CityNameRepositoryImpl extends ICityNameRepository {
  final ICityNameService iCityNameService;

  final ILocationServiceGeoLocatorProvider iLocationServiceGeoLocatorProvider;

  CityNameRepositoryImpl({
    required this.iCityNameService,
    required this.iLocationServiceGeoLocatorProvider,
  });

  @override
  Future<Either<IFailure, String>> getCityName(
      LocationEntity locationEntity) async {
    try {
      // LocationModel locationModel = LocationModel.fromJson(params);
      double? lat = locationEntity.lat;
      double? lon = locationEntity.lon;

      if (lat == null || lon == null) {
        Position? position =
            await iLocationServiceGeoLocatorProvider.getCurrentLocation();

        lat = position?.latitude;
        lon = position?.longitude;
      }

      if (lat != null && lon != null) {
        String? cityName =
            await iCityNameService.getCityName(lat: lat, lon: lon);
        debugPrint('GeoLocationRepository | getCityName | cityName: $cityName');
        if (cityName != null) {
          return Right<LocationError, String>(cityName);
        }
      }
      return Left<IFailure, String>(LocationFailure());
    } catch (e) {
      debugPrint(
          'GeoLocationRepository | GeoLocationRepository | getCityName | Error: $e');
      return Left<IFailure, String>(LocationFailure());
    }
  }
}
