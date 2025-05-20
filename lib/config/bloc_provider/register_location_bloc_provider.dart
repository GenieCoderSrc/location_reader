import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it_di_global_variable/get_it_di.dart';
import 'package:location_reader/view_model/city_name_cubit/city_name_cubit.dart';
import 'package:location_reader/view_model/country_code_cubit/country_code_cubit.dart';
import 'package:location_reader/view_model/location_picker_cubit/location_picker_cubit.dart';
import 'package:provider/single_child_widget.dart';

// ---- Location bloc provider ------
late LocationPickerCubit _locationPickerCubit;
late CityNameCubit _cityNameCubit;
late CountryCodeCubit _countryCodeCubit;

initLocationBlocProvider() {
  // ---- Location Cubit Init ------
  _locationPickerCubit = sl<LocationPickerCubit>();
  _cityNameCubit = sl<CityNameCubit>();
  _countryCodeCubit = sl<CountryCodeCubit>();
}

disposeLocationBlocProvider() {
  // ---- Location Cubit Dispose ------
  _locationPickerCubit.close();
  _cityNameCubit.close();
  _countryCodeCubit.close();
}

List<SingleChildWidget> locationBlocProviders = [
  // ---- Location Cubit Bloc Provider ------
  BlocProvider<LocationPickerCubit>(create: (BuildContext context) => _locationPickerCubit),
  BlocProvider<CityNameCubit>(create: (BuildContext context) => _cityNameCubit),
  BlocProvider<CountryCodeCubit>(create: (BuildContext context) => _countryCodeCubit),
];
