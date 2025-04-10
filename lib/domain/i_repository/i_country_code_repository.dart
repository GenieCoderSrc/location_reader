import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';

abstract class ICountryCodeRepository {
  Future<Either<IFailure, String>> getCountryCode();
}
