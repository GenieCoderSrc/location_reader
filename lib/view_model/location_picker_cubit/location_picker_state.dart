part of 'location_picker_cubit.dart';

class LocationPickerState extends Equatable {
  const LocationPickerState({this.locationEntity, this.reportMsg});

  final LocationEntity? locationEntity;
  final String? reportMsg;

  LocationPickerState copyWith(
          {LocationEntity? locationEntity, String? reportMsg}) =>
      LocationPickerState(
        locationEntity: locationEntity ?? this.locationEntity,
        reportMsg: reportMsg ?? this.reportMsg,
      );

  LocationPickerState clear() =>
      const LocationPickerState(locationEntity: null, reportMsg: null);

  @override
  List<Object?> get props => [locationEntity];
}
