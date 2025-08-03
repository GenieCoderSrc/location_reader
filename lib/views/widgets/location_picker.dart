import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_reader/view_model/location_picker_cubit/location_picker_cubit.dart';

import 'city_name_builder.dart';

class LocationPicker extends StatelessWidget {
  final double? lat, lon;
  final VoidCallback? onTap;

  const LocationPicker({super.key, this.lat, this.lon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap:
            onTap ?? () => context.read<LocationPickerCubit>().pickLocation(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              'Location: ',
              style: TextStyle(
                // color: Colors.grey,
                fontSize: 15.0,
                color: Colors.blueGrey.shade600,
                fontWeight: FontWeight.bold,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 12.0),
              child: BlocBuilder<LocationPickerCubit, LocationPickerState>(
                buildWhen: (current, previous) => current != previous,
                builder: (context, state) {
                  debugPrint(
                    'LocationPicker | build | state:=> lat: ${state.locationEntity?.lat} ',
                  );
                  return CityNameBuilder(
                    lat: lat ?? state.locationEntity?.lat,
                    lon: lon ?? state.locationEntity?.lon,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
