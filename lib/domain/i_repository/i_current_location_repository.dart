import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:location_reader/domain/entities/location_entity.dart';

abstract class ICurrentLocationRepository {
  Future<Either<IFailure, LocationEntity>> getCurrentLocation();
}
