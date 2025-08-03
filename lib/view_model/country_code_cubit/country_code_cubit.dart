import 'package:dartz/dartz.dart';
import 'package:exception_type/exception_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:i_tdd/i_tdd.dart';
import 'package:location_reader/domain/usecases/get_country_code.dart';

import 'country_code_state.dart';

class CountryCodeCubit extends Cubit<CountryCodeState> {
  final GetCountryCode getCountryCode;

  CountryCodeCubit({required this.getCountryCode})
    : super(const CountryCodeInitial());

  Future<String> loadCountryCode() async {
    late String countryCode;
    emit(const CountryCodeLoading());
    final Either<IFailure, String> eitherResponse = await getCountryCode(
      NoParams(),
    );

    eitherResponse.fold(
      (l) {
        final String message = mapFailureToMessage(l);
        debugPrint('init country code error: $message');
        emit(CountryCodeError(message));
        countryCode = 'US';
      },
      (r) {
        debugPrint('init country code: $r');
        emit(CountryCodeLoaded(r));
        countryCode = r;
      },
    );
    return countryCode;
  }
}
