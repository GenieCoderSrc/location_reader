import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/i_repository/i_country_code_repository.dart';

class GetCountryCode extends IEitherUseCase<String, NoParams> {
  final ICountryCodeRepository _iCountryCodeRepository;

  GetCountryCode(this._iCountryCodeRepository);

  @override
  Future<Either<IFailure, String>> call(NoParams params) async =>
      _iCountryCodeRepository.getCountryCode();
}
