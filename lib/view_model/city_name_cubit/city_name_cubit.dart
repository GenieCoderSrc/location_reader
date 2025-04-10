import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/usecases/get_city_name.dart';
import 'package:location_reader/view_model/city_name_cubit/city_name_state.dart';
import 'package:location_reader/view_model/location_picker_cubit/location_picker_cubit.dart';

class CityNameCubit extends Cubit<CityNameState> {
  final GetCityName getCityName;

  final LocationPickerCubit locationPickerCubit;

  CityNameCubit({
    required this.getCityName,
    required this.locationPickerCubit,
  }) : super(const CityNameInitial());

  Future<void> loadCityName({double? lat, double? lon}) async {
    emit(const CityNameLoading());

    debugPrint('CityNameCubit | loadCityName | lat: $lat lon: $lon');

    if (lat == null || lon == null) {
      LocationEntity? locationEntity = locationPickerCubit.state.locationEntity;
      lat = locationEntity?.lat;
      lon = locationEntity?.lon;
    }

    final Either<IFailure, String> eitherResponse =
        await getCityName(LocationEntity(lat: lat, lon: lon));

    // check report
    eitherResponse.handleReport(
      onSuccess: (String cityName) => emit(CityNameLoaded(cityName)),
      onFailed: (message) => emit(CityNameLoadingFailure(message)),
    );
  }
}
