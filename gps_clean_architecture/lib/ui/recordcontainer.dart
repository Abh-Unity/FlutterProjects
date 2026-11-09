import 'package:flutter/material.dart';

class recordcontainer extends StatefulWidget {
  final longitude;
  final latitude;
  final altitude;
  final userid;
  final timestamp;

  const recordcontainer({
    super.key,
    required this.longitude,
    required this.latitude,
    required this.altitude,
    required this.userid,
    required this.timestamp,
  });

  @override
  State<recordcontainer> createState() => _recordcontainerState();
}

class _recordcontainerState extends State<recordcontainer> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Text("Longitude: ${widget.longitude}"),
          Text("Latitude: ${widget.latitude}"),
          Text("Altitude: ${widget.altitude}"),
          Text("Device ID: ${widget.userid}"),
          Text("timestamp: ${widget.timestamp}"),
        ],
      ),
    );
  }
}
