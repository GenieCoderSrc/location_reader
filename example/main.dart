// main.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location_reader/location_reader.dart';

void main() {
  registerLocationServiceGetItDi();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Reader Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationExamplePage(),
    );
  }
}

class LocationExamplePage extends StatelessWidget {
  const LocationExamplePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Location Reader Example')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton(
              onPressed: () async {
                final getLocation = sl<GetCurrentLocation>();
                final result = await getLocation();

                result.fold(
                      (failure) => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Error"),
                      content: Text(failure.toString()),
                    ),
                  ),
                      (location) => showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text("Current Location"),
                      content: Text(
                          'Lat: ${location.latitude}, Lng: ${location.longitude}'),
                    ),
                  ),
                );
              },
              child: const Text('Get Current Location'),
            ),
            const SizedBox(height: 24),
            const CountryCodeLoader(
              page: (code) => Text("Country Code: \$code"),
            ),
          ],
        ),
      ),
    );
  }
}
