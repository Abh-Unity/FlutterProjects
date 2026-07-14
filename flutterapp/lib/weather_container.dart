import 'package:flutter/material.dart';

class weathercard extends StatefulWidget {
  final String? cityname;
  final String? date;

  const weathercard({super.key,this.cityname,this.date});

  @override
  State<weathercard> createState() => _weathercardState();
}

class _weathercardState extends State<weathercard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          Text(widget.cityname?? 'unknown city'),
          Text(widget.date?? 'unknown data')
        ],
      ),
    );
  }
}