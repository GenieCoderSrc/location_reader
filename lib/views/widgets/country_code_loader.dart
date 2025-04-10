import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_reader/view_model/country_code_cubit/country_code_cubit.dart';

class CountryCodeLoader extends StatelessWidget {
  const CountryCodeLoader({super.key, required this.page});

  final Widget Function(String countryCode) page;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: context.read<CountryCodeCubit>().loadCountryCode(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return page('BD');
        } else if (snapshot.hasError) {
          return page('BD');
        } else if (snapshot.hasData) {
          return page(snapshot.data ?? 'BD');
        } else {
          return page('BD');
        }
      },
    );
  }
}

// class CountryCodeLoader extends StatelessWidget {
//   const CountryCodeLoader({super.key, required this.pageBuilder});
//
//   final Function pageBuilder;
//
//   @override
//   Widget build(BuildContext context) {
//     return FutureLoader<String>(
//         future: context.read<CountryCodeCubit>().loadCountryCode(),
//         onSuccessHasData: (_, AsyncSnapshot<String> snapshot) =>
//             pageBuilder(snapshot.data) as Widget,
//         onSuccessNoData: (_, __) => pageBuilder('BD') as Widget,
//         onWaiting: (_, __) => pageBuilder('BD') as Widget,
//         onError: (_, __) => pageBuilder('BD') as Widget);
//   }
// }

// BlocProvider.of<CountryCodeCubit>(context).getInitialCountryCode();
// return BlocBuilder<CountryCodeCubit, CountryCodeState>(
//   builder: (context, state) {
//     if (state is CountryCodeInitial) {
//       return page('CA') as Widget;
//     } else if (state is CountryCodeLoading) {
//       return page('US') as Widget;
//     } else if (state is CountryCodeLoaded) {
//       return page(state.countryCode) as Widget;
//     } else {
//       // (state is WeatherError)
//       return page('IN') as Widget;
//     }
//   },
// );
