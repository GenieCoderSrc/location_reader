import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/i_repository/i_current_location_repository.dart';

class GetCurrentLocation extends IEitherUseCase<LocationEntity, NoParams> {
  final ICurrentLocationRepository _iCurrentLocationRepository;

  GetCurrentLocation(this._iCurrentLocationRepository);

  @override
  Future<Either<IFailure, LocationEntity>> call(NoParams params) async =>
      _iCurrentLocationRepository.getCurrentLocation();
}
