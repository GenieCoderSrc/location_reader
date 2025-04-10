import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/foundation.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/usecases/get_current_location.dart';

part 'location_picker_state.dart';

class LocationPickerCubit extends Cubit<LocationPickerState> {
  LocationPickerCubit(
      {required this.getCurrentLocation, required this.loadingCubit})
      : super(const LocationPickerState());

  final GetCurrentLocation getCurrentLocation;
  final LoadingCubit loadingCubit;

  Future<void> pickLocation() async {
    debugPrint('LocationPickerCubit | pickLocation | ');
    loadingCubit.show();
    final Either<IFailure, LocationEntity> eitherResponse =
        await getCurrentLocation(NoParams());

    loadingCubit.show();

    eitherResponse.handleReport(
      successMsg: 'Location Picked Successfully!',
      onSuccess: (locationEntity) =>
          emit(state.copyWith(locationEntity: locationEntity)),
      onFailed: (message) => emit(state.copyWith(
          reportMsg: "$message!\n Please! Enable GPS permission")),
      isDisplayFailedMsg: true,
    );
  }
}
