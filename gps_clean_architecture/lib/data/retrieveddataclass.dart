class retrieved_data {
  final Longitude;
  final Latitude;
  final Altitude;
  final timestamp;

  retrieved_data({
    required this.Longitude,
    required this.Latitude,
    required this.Altitude,
    required this.timestamp,
  });

  factory retrieved_data.frombackend(Map<String, dynamic> data) {
    return retrieved_data(
      Longitude: data["longitude"],
      Latitude: data["latitude"],
      Altitude: data["altitude"],
      timestamp: data["recorded_at"],
    );
  }
}
