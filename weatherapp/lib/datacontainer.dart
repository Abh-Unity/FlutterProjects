import 'package:flutter/material.dart';

class datacontain extends StatefulWidget {
  final latitude;
  final longitude;
  final timezone;
  final elevation;
  final temperature;

  const datacontain({
    super.key,
    this.latitude,
    this.longitude,
    this.timezone,
    this.elevation,
    this.temperature,
  });

  @override
  State<datacontain> createState() => _datacontainState();
}

class _datacontainState extends State<datacontain> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 3,
            children: [
              Text("Current Temperature:" + widget.temperature.toString()),
              Text("Current Elevation:" + widget.elevation.toString()),
              Text("Current Timezone:" + widget.timezone.toString()),
              Text("Current Longitude:" + widget.longitude.toString()),
              Text("Current Latitude:" + widget.latitude.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
