import 'package:flutter/material.dart';

class contain extends StatefulWidget {
  final userid;
  final id;
  final title;

  const contain({
    super.key,
    required this.userid,
    required this.id,
    required this.title,
  });

  @override
  State<contain> createState() => _containState();
}

class _containState extends State<contain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("the fetched id is:" + widget.id.toString()),
          Text("the fetched user id is:" + widget.userid.toString()),
          Text("the fetched title is:" + widget.title),
        ],
      ),
    );
  }
}
