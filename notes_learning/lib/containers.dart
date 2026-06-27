import 'package:flutter/material.dart';

class notes_tile extends StatefulWidget {
  final String text;

  const notes_tile({super.key, required this.text});

  @override
  State<notes_tile> createState() => _notes_tileState();
}

class _notes_tileState extends State<notes_tile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("data", style: TextStyle(color: Colors.white)),
      decoration: BoxDecoration(color: Colors.grey),
    );
  }
}
