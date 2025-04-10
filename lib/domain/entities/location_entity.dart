import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'location_entity.g.dart';

// flutter packages pub run build_runner build --delete-conflicting-outputs
// flutter packages pub run build_runner watch --delete-conflicting-outputs

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class LocationEntity extends Equatable {
  final double? lat;
  final double? lon;

  const LocationEntity({this.lat, this.lon});

  factory LocationEntity.fromJson(Map<String, dynamic> json) =>
      _$LocationEntityFromJson(json);

  Map<String, dynamic> toJson() => _$LocationEntityToJson(this);

  @override
  List<Object?> get props => [lat, lon];
}
