import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_reader/view_model/city_name_cubit/city_name_cubit.dart';
import 'package:location_reader/view_model/city_name_cubit/city_name_state.dart';

class CityNameBuilder extends StatelessWidget {
  const CityNameBuilder({
    super.key,
    required this.lat,
    required this.lon,
    this.textStyle,
    this.locationIconColor,
  });

  final double? lat;
  final double? lon;
  final TextStyle? textStyle;
  final Color? locationIconColor;

  @override
  Widget build(BuildContext context) {
    return lat != null && lon != null
        ? BlocBuilder<CityNameCubit, CityNameState>(
            bloc: BlocProvider.of<CityNameCubit>(context)
              ..loadCityName(lat: lat, lon: lon),
            buildWhen: (previous, current) =>
                previous != current && current is CityNameLoaded,
            builder: (context, state) {
              debugPrint('CityNameBuilder state: ${state.props}');
              if (state is CityNameLoaded) {
                return Text(
                  state.cityName,
                  style: textStyle ??
                      TextStyle(
                        // color: Colors.grey,
                        fontSize: 15.0,
                        color: Colors.blueGrey.shade600,
                        fontWeight: FontWeight.bold,
                      ),
                );
              }
              return const Text('loading...');
            })
        : Icon(Icons.location_on_outlined, color: locationIconColor);
  }
}

// ? FutureLoader<String>(
//     // future: _nearByJathaProvider.getCityName(lat: lat, lon: lon),
//     future: context
//         .read<CityNameCubit>()
//         .loadCityName(lat: lat!, lon: lon!),
//     onSuccessHasData: (_, AsyncSnapshot<String?> snapshot) => Text(
//       snapshot.data ?? '',
//       style: textStyle ?? kMidSmallTextStyle,
//     ),
//     onWaiting: (_, __) => Container(),
//   )
