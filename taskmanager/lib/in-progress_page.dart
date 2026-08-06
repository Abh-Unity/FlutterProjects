import 'package:flutter/material.dart';

class inprogresspg extends StatefulWidget {
  const inprogresspg({super.key});

  @override
  State<inprogresspg> createState() => _inprogresspgState();
}

class _inprogresspgState extends State<inprogresspg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("In-Progress tasks"),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Center(child: Text("Still In Development")),
    );
  }
}
