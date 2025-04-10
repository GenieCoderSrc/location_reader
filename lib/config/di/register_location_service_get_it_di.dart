import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:location_reader/data/data_sources/address_service_impl.dart';
import 'package:location_reader/data/data_sources/city_name_service_impl.dart';
import 'package:location_reader/data/data_sources/country_code_service_impl.dart';
import 'package:location_reader/data/data_sources/geo_fire_point_converter_impl.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_address_service.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_city_name_service.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_country_code_service.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_geo_fire_point_converter.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_permission_manager.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_fire_point_provider.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_location_service_geo_locator_provider.dart';
import 'package:location_reader/data/data_sources/i_location_services/i_nearby_location_service.dart';
import 'package:location_reader/data/data_sources/location_permission_manager_geo_locator_provider_impl.dart';
import 'package:location_reader/data/data_sources/location_service_geo_fire_point_provider_impl.dart';
import 'package:location_reader/data/data_sources/location_service_geo_locator_provider_impl.dart';
import 'package:location_reader/data/data_sources/nearby_location_geofire_service_impl.dart';
import 'package:location_reader/data/repositories/city_name_repository_impl.dart';
import 'package:location_reader/data/repositories/country_code_repository_impl.dart';
import 'package:location_reader/data/repositories/current_location_repository_impl.dart';
import 'package:location_reader/domain/i_repository/i_city_name_repository.dart';
import 'package:location_reader/domain/i_repository/i_country_code_repository.dart';
import 'package:location_reader/domain/i_repository/i_current_location_repository.dart';
import 'package:location_reader/domain/usecases/get_city_name.dart';
import 'package:location_reader/domain/usecases/get_country_code.dart';
import 'package:location_reader/domain/usecases/get_current_location.dart';
import 'package:location_reader/view_model/city_name_cubit/city_name_cubit.dart';
import 'package:location_reader/view_model/country_code_cubit/country_code_cubit.dart';
import 'package:location_reader/view_model/location_picker_cubit/location_picker_cubit.dart';

void registerLocationServiceGetItDi() {
  /// Service
  sl.registerLazySingleton<IAddressService>(() => AddressServiceImpl());
  sl.registerLazySingleton<ICityNameService>(() => CityNameServiceImpl());
  sl.registerLazySingleton<ICountryCodeService>(() => CountryCodeServiceImpl());
  sl.registerLazySingleton<ILocationPermissionManager>(
      () => LocationPermissionManagerGeolocatorProviderImpl());
  sl.registerLazySingleton<IGeoFirePointConverter>(
      () => GeoFirePointConverterImpl());

  sl.registerLazySingleton<ILocationServiceGeoFirePointProvider>(() =>
      LocationServiceGeoFirePointProviderImpl(
          iLocationServiceGeoLocatorProvider: sl(),
          iGeoFirePointConverter: sl()));

  sl.registerLazySingleton<ILocationServiceGeoLocatorProvider>(() =>
      LocationServiceGeoLocatorProviderImpl(iLocationPermissionManager: sl()));
  sl.registerLazySingleton<INearbyLocationService>(
      () => NearbyLocationService());

  /// ------ Repository -----
  sl.registerLazySingleton<ICurrentLocationRepository>(() =>
      CurrentLocationRepositoryImpl(iLocationServiceGeoLocatorProvider: sl()));
  sl.registerLazySingleton<ICityNameRepository>(() => CityNameRepositoryImpl(
      iCityNameService: sl(), iLocationServiceGeoLocatorProvider: sl()));
  sl.registerLazySingleton<ICountryCodeRepository>(() =>
      CountryCodeRepositoryImpl(
          iLocationServiceGeoLocatorProvider: sl(), iCountryCodeService: sl()));

  /// ------ Use Cases -----
  sl.registerLazySingleton<GetCityName>(() => GetCityName(sl()));
  sl.registerLazySingleton<GetCountryCode>(() => GetCountryCode(sl()));
  sl.registerLazySingleton<GetCurrentLocation>(() => GetCurrentLocation(sl()));

  // View Models
  sl.registerLazySingleton(
      () => LocationPickerCubit(getCurrentLocation: sl(), loadingCubit: sl()));
  sl.registerFactory(
      () => CityNameCubit(getCityName: sl(), locationPickerCubit: sl()));
  sl.registerFactory(() => CountryCodeCubit(getCountryCode: sl()));
}
