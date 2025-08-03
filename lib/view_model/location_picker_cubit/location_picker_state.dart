part of 'location_picker_cubit.dart';

class LocationPickerState extends Equatable {
  const LocationPickerState({
    this.locationEntity,
    this.reportMsg,
    this.isLoading = false,
  });

  final LocationEntity? locationEntity;
  final String? reportMsg;
  final bool isLoading;

  LocationPickerState copyWith({
    LocationEntity? locationEntity,
    String? reportMsg,
    bool? isLoading,
  }) => LocationPickerState(
    locationEntity: locationEntity ?? this.locationEntity,
    reportMsg: reportMsg ?? this.reportMsg,
    isLoading: isLoading ?? this.isLoading,
  );

  LocationPickerState clear() => const LocationPickerState();

  @override
  List<Object?> get props => [locationEntity, reportMsg, isLoading];
}
