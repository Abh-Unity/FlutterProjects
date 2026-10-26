import 'package:geolocator/geolocator.dart';

class data {
  final longitude;
  final latitude;
  final altitude;

  data({
    required this.longitude,
    required this.latitude,
    required this.altitude,
  });

  factory data.fromgps(Position pos) {
    return data(
      longitude: pos.longitude,
      latitude: pos.latitude,
      altitude: pos.altitude,
    );
  }
}
