import 'package:flutter/material.dart';

class containCoords extends StatefulWidget {
  final Longitude;
  final Latitude;
  final Altitude;
  final Time;

  containCoords({
    super.key,
    required this.Longitude,
    required this.Latitude,
    required this.Altitude,
    required this.Time,
  });

  @override
  State<containCoords> createState() => _containCoordsState();
}
//i am leaving this here tomorrow i am gonna build a ui through figma then proceed forward

class _containCoordsState extends State<containCoords> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 403,
      height: 120,
      child: Stack(
        children: [
          Positioned(
            left: 15,
            top: 0,
            child: Text(
              'Longitude:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 32,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 95,
            child: Text(
              'Current Longitude:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 169,
            top: 95,
            child: Text(
              'longitude value',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
