import 'package:flutter/material.dart';

class Completepg extends StatefulWidget {
  const Completepg({super.key});

  @override
  State<Completepg> createState() => _completepgState();
}

class _completepgState extends State<Completepg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed tasks"),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: Center(child: Text("Still In Development")),
    );
  }
}
