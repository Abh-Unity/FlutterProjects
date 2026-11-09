import 'package:flutter/material.dart';

class recordcontainer extends StatefulWidget {
  final longitude;
  final latitude;
  final altitude;
  final timestamp;

  const recordcontainer({
    super.key,
    required this.longitude,
    required this.latitude,
    required this.altitude,
    required this.timestamp,
  });

  @override
  State<recordcontainer> createState() => _recordcontainerState();
}

class _recordcontainerState extends State<recordcontainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 403,
      height: 180,
      child: Stack(
        children: [
          Positioned(
            left: 5,
            top: 3,
            bottom: 3,
            child: Container(
              width: 403,
              height: 210,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  side: BorderSide(
                    width: 2,
                    strokeAlign: BorderSide.strokeAlignOutside,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                shadows: [
                  BoxShadow(
                    color: Color(0x3F000000),
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    spreadRadius: 0,
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 5,
            child: Text(
              'Longitude:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 5,
            child: Text(
              "${widget.longitude}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 88,
            child: Text(
              'Altitude:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 88,
            child: Text(
              "${widget.altitude}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          Positioned(
            left: 15,
            top: 130,
            child: Text(
              'Date:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 130,
            width: 250,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${widget.timestamp}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Fredoka One',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
          Positioned(
            left: 15,
            top: 47,
            child: Text(
              'Latitude:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontFamily: 'Fredoka One',
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Positioned(
            left: 125,
            top: 47,
            child: Text(
              "${widget.latitude}",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
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
