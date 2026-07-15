import 'package:flutter/material.dart';
import 'package:weatherapp/datafetch.dart';

class Weather extends StatefulWidget {
  final Future<void> Function()? fun;

  const Weather({super.key, this.fun});

  @override
  State<Weather> createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("WEATHER"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: Center(
        heightFactor: 35,
        child: Text(
          "Click on the " + " button to check the weather in kathmandu.",
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await widget.fun?.call();
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => fetch()));
        },
        child: Text("check"),
      ),
    );
  }
}
