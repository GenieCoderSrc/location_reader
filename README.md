# location_reader

`location_reader` is a Flutter package designed to simplify the process of retrieving and handling location-related data. It supports features such as obtaining the current location, converting coordinates to city names or country codes, managing location permissions, and performing nearby location queries with GeoFirePoint and Firebase.

## Features

- 🌍 Get current location using `Geolocator`
- 🏙️ Convert latitude and longitude to city name and country code using `geocoding`
- 📍 Retrieve `GeoFirePoint` objects for use in Firebase
- 📡 Nearby location query support via `geoflutterfire2`
- 🔐 Seamless location permission handling
- 💡 Clean architecture with services, repositories, use cases, and cubits

## Installation

Add the following to your `pubspec.yaml`:

```yaml
resolution: workspace

dependencies:
  location_reader: ^<latest_version>
```

Then run:

```bash
flutter pub get
```

## Getting Started

### 1. Register Dependencies

Ensure you call the DI registration method before using the services:

```dart
registerLocationServiceGetItDi();
```

### 2. Use Cases

You can access location-related use cases like this:

```dart
final getCurrentLocation = sl<GetCurrentLocation>();
final location = await getCurrentLocation();
```

### 3. UI Integration

Use `LocationPicker` and `CountryCodeLoader` widgets:

```dart
LocationPicker(
  onTap: () => // pick location logic,
)
```

```dart
CountryCodeLoader(
  page: (code) => Text("Country: $code"),
)
```

## Dependencies

- [geolocator]
- [geocoding]
- [geoflutterfire2]
- [flutter_bloc]
- [get_it]
- [dartz]
- [json_serializable]

## Example Use Cases

- `GetCityName`
- `GetCountryCode`
- `GetCurrentLocation`

All of these use cases internally handle permissions, errors, and edge cases.

## JSON Support

The `LocationModel` class supports JSON serialization using `json_serializable`.

## Error Handling

Utilizes `Either` from `dartz` and custom `IFailure`/`LocationError` for structured error handling.

## Contributing

Feel free to open issues and contribute pull requests for enhancements or bug fixes.

## License

MIT License. See `LICENSE` file for details.
