import 'package:geolocator_android/geolocator_android.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:hive_ce/hive_ce.dart';

part 'hold_data.g.dart';

@HiveType(typeId: 0)
class hold_data {
  @HiveField(0)
  final double Longitude;
  @HiveField(1)
  final Latitude;
  @HiveField(2)
  final Altitude;
  @HiveField(3)
  final deviceid;
  @HiveField(4)
  final DateTime time;

  hold_data({
    required this.Longitude,
    required this.Latitude,
    required this.Altitude,
    required this.deviceid,
    required this.time,
  });

  factory hold_data.fromgps(Position pos, String id, DateTime datentime) {
    return hold_data(
      Longitude: pos.longitude,
      Latitude: pos.latitude,
      Altitude: pos.altitude,
      deviceid: id,
      time: datentime,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "longitude": Longitude,
      "latitude": Latitude,
      "altitude": Altitude,
      "user_id": deviceid,
      "time": time.toUtc().toIso8601String(),
    };
  }
}
