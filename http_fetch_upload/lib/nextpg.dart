import 'package:flutter/material.dart';

class Nextpage extends StatefulWidget {
  final List? transferred_data;
  final int? index;

  const Nextpage({super.key, this.transferred_data, this.index});

  @override
  State<Nextpage> createState() => _NextpageState();
}

class _NextpageState extends State<Nextpage> {
  @override
  Widget build(BuildContext context) {
    return widget.transferred_data != null
        ? Card(
            child: Column(
              children: [
                Text(
                  widget.transferred_data![widget.index!].toString(),
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
          )
        : Text("Loading....");
  }
}
