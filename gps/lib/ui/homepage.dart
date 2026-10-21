import 'package:flutter/material.dart';
import 'package:gps/logic/gpshandler.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  @override
  void initState() {
    gpsenabled();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gps")),
      body: Align(
        alignment: .center,
        child: Card(
          child: SizedBox(
            height: 40,
            child: Align(
              alignment: .center,
              child: Text("these are the longitudes and latitudes:"),
            ),
          ),
        ),
      ),
    );
  }
}
