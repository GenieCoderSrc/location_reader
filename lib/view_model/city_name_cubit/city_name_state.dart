import 'package:equatable/equatable.dart';

abstract class CityNameState extends Equatable {
  const CityNameState();

  @override
  List<Object> get props => <Object>[];
}

class CityNameInitial extends CityNameState {
  const CityNameInitial();
}

class CityNameLoading extends CityNameState {
  const CityNameLoading();
}

class CityNameLoaded extends CityNameState {
  final String cityName;
  const CityNameLoaded(this.cityName);

  @override
  List<Object> get props => <Object>[cityName];
}
// class CityNameLoaded extends CityNameState {
//   final String cityName;
//   const CityNameLoaded(this.cityName);
//
//   @override
//   List<Object> get props => <Object>[cityName];
// }

class CityNameLoadingFailure extends CityNameState {
  final String message;
  const CityNameLoadingFailure(this.message);

  @override
  List<Object> get props => <Object>[message];
}
