import 'package:flutter/material.dart';
import 'package:location_reader/config/di/register_location_service_get_it_di.dart';
import 'package:location_reader/location_reader.dart';  // Import the location_reader package
import 'package:get_it/get_it.dart';

void main() {
  // Register dependencies
  registerLocationServiceGetItDi();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Location Reader Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LocationScreen(),
    );
  }
}

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  String locationMessage = "Fetching location...";

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  Future<void> _getLocation() async {
    final locationRepository = GetIt.I<ICurrentLocationRepository>();
    final result = await locationRepository.getCurrentLocation();

    result.fold(
          (failure) {
        setState(() {
          locationMessage = "Error fetching location: ${failure.toString()}";
        });
      },
          (location) {
        setState(() {
          locationMessage = "Current Location: \nLat: ${location.lat}, Lon: ${location.lon}";
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location Reader Example'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            locationMessage,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 20),
          ),
        ),
      ),
    );
  }
}
