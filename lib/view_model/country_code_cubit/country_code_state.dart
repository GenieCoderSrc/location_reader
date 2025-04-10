import 'package:equatable/equatable.dart';

abstract class CountryCodeState extends Equatable {
  const CountryCodeState();

  @override
  List<Object> get props => <Object>[];
}

class CountryCodeInitial extends CountryCodeState {
  const CountryCodeInitial();
}

class CountryCodeLoading extends CountryCodeState {
  const CountryCodeLoading();
}

class CountryCodeLoaded extends CountryCodeState {
  final String countryCode;
  const CountryCodeLoaded(this.countryCode);

  @override
  List<Object> get props => <Object>[countryCode];
}

class CountryCodeError extends CountryCodeState {
  final String message;
  const CountryCodeError(this.message);

  @override
  List<Object> get props => <Object>[message];
}
