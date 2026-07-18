import 'package:flutter/material.dart';

class prefab extends StatefulWidget {
  Map<dynamic, dynamic>? files;

  prefab({super.key, this.files});

  @override
  State<prefab> createState() => _prefabState();
}

class _prefabState extends State<prefab> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [Text(widget.files!["id"]), Text(widget.files!["name"])],
      ),
    );
  }
}
