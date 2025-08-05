import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/usecases/get_current_location.dart';

part 'location_picker_state.dart';

class LocationPickerCubit extends Cubit<LocationPickerState> {
  LocationPickerCubit({required this.getCurrentLocation})
    : super(const LocationPickerState());

  final GetCurrentLocation getCurrentLocation;

  Future<void> pickLocation() async {
    emit(state.copyWith(isLoading: true));
    final result = await getCurrentLocation(NoParams());
    emit(state.copyWith(isLoading: false));

    result.handleReport(
      successMsg: 'Location Picked Successfully!',
      onSuccess: (location) => emit(state.copyWith(locationEntity: location)),
      onFailed: (msg) => emit(
        state.copyWith(reportMsg: "$msg!\nPlease! Enable GPS permission"),
      ),
      isDisplayFailedMsg: true,
    );
  }
}
