// import 'package:dartz/dartz.dart';
// import 'package:exceptions/exceptions.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:location_reader/data/data_sources/i_location_services/i_city_name_service.dart';
// import 'package:location_reader/data/data_sources/i_location_services/i_country_code_service.dart';
// import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_locator_provider.dart';
// import 'package:location_reader/data/model/location_model.dart';
// import 'package:location_reader/domain/i_repository/i_location_repository.dart';
//
// class GeoLocationRepository extends ILocationRepository {
//   final ILocationServiceGeoLocatorProvider iLocationService;
//   final ICountryCodeService iCountryCodeService;
//   final ICityNameService iCityNameService;
//
//   GeoLocationRepository({
//     required this.iCountryCodeService,
//     required this.iCityNameService,
//     required this.iLocationService,
//   });
//
//   @override
//   Future<Either<IFailure, String>> getCurrentCountryCode() async {
//     try {
//       late String? countryCode;
//       final Position? currentLocation =
//           await iLocationService.getLastKnownPosition() ??
//               await iLocationService.getCurrentLocation();
//
//       debugPrint(
//           'GeoLocationRepository | getCurrentCountryCode | currentLocation: $currentLocation');
//
//       if (currentLocation != null) {
//         countryCode = await iCountryCodeService.getCountryCode(
//             lat: currentLocation.latitude, lon: currentLocation.longitude);
//       }
//       debugPrint(
//           'GeoLocationRepository | getCurrentCountryCode | countryCode: $countryCode');
//       return Right<LocationError, String>(countryCode ?? 'US');
//     } catch (e) {
//       debugPrint('GeoLocationRepository | getCurrentCountryCode | Error: $e');
//       return const Right<LocationError, String>('US');
//     }
//   }
//
//   @override
//   Future<Either<IFailure, String>> getCityName(
//       Map<String, dynamic> params) async {
//     try {
//       LocationModel locationModel = LocationModel.fromJson(params);
//       double? lat = locationModel.lat;
//       double? lon = locationModel.lon;
//
//       if (lat != null && lon != null) {
//         String? cityName =
//             await iCityNameService.getCityName(lat: lat, lon: lon);
//         debugPrint('GeoLocationRepository | getCityName | cityName: $cityName');
//         if (cityName != null) {
//           return Right<LocationError, String>(cityName);
//         }
//       }
//       return Left<IFailure, String>(LocationFailure());
//     } catch (e) {
//       debugPrint(
//           'GeoLocationRepository | GeoLocationRepository | getCityName | Error: $e');
//       return Left<IFailure, String>(LocationFailure());
//     }
//   }
//
//   @override
//   Future<Either<IFailure, Position?>> getCurrentLocation() async {
//     try {
//       Position? position = await iLocationService.getCurrentLocation();
//       if (position != null) {
//         return Right(position);
//       }
//       return const Left(LocationError(LocationErrorType.permissionDenied));
//     } catch (e) {
//       return const Left(LocationError(LocationErrorType.permissionDenied));
//     }
//   }
// }
