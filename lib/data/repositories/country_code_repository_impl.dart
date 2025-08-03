import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_country_code_service.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_locator_provider.dart';
import 'package:location_reader/domain/i_repository/i_country_code_repository.dart';

class CountryCodeRepositoryImpl extends ICountryCodeRepository {
  final ILocationServiceGeoLocatorProvider iLocationServiceGeoLocatorProvider;
  final ICountryCodeService iCountryCodeService;

  CountryCodeRepositoryImpl({
    required this.iLocationServiceGeoLocatorProvider,
    required this.iCountryCodeService,
  });

  @override
  Future<Either<IFailure, String>> getCountryCode() async {
    try {
      late String? countryCode;
      final Position? currentLocation =
          await iLocationServiceGeoLocatorProvider.getLastKnownPosition() ??
          await iLocationServiceGeoLocatorProvider.getCurrentLocation();

      debugPrint(
        'GeoLocationRepository | getCurrentCountryCode | currentLocation: $currentLocation',
      );

      if (currentLocation != null) {
        countryCode = await iCountryCodeService.getCountryCode(
          lat: currentLocation.latitude,
          lon: currentLocation.longitude,
        );
      }
      debugPrint(
        'GeoLocationRepository | getCurrentCountryCode | countryCode: $countryCode',
      );
      return Right<LocationError, String>(countryCode ?? 'US');
    } catch (e) {
      debugPrint('GeoLocationRepository | getCurrentCountryCode | Error: $e');
      return const Right<LocationError, String>('US');
    }
  }
}
