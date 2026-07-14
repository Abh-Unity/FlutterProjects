import 'package:flutter/material.dart';

class notepage extends StatelessWidget {
  const notepage({super.key});

  @override
  Widget build(BuildContext context) {
    return note();
  }
}

class note extends StatefulWidget {
  const note({super.key});

  @override
  State<note> createState() => _noteState();
}

class _noteState extends State<note> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_left, color: Colors.white),
        ),
        title: Text("Add Notes.", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          TextField(
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
              hintText: "Title",
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.white38),
            ),
          ),
          TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: "Description",
              hintStyle: TextStyle(color: Colors.white38),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }
}
