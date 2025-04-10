import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/entities/location_entity.dart';
import 'package:location_reader/domain/i_repository/i_city_name_repository.dart';

class GetCityName extends IEitherUseCase<String, LocationEntity> {
  final ICityNameRepository _iCityNameRepository;

  GetCityName(this._iCityNameRepository);

  @override
  Future<Either<IFailure, String>> call(LocationEntity params) async =>
      _iCityNameRepository.getCityName(params);
}
