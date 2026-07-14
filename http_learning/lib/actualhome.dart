import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:http_learning/container.dart';

class Myhome extends StatefulWidget {
  const Myhome({super.key});

  @override
  State<Myhome> createState() => _MyhomeState();
}

class _MyhomeState extends State<Myhome> {
  void onPressed() async {
    await getdata();
    setState(() {});
  }

  Map<String, dynamic>? datacollected;

  Future<void> getdata() async {
    try {
      var response = await http.get(
        Uri.parse("https://jsonplaceholder.typicode.com/posts/1"),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        datacollected = data;
      }
    } catch (e) {
      datacollected = null;
      SnackBar(content: Text("fetching of data failed."));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Get data from the web"),
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: onPressed,
        child: Text("+"),
      ),
      body: datacollected != null
          ? Expanded(
              child: ListView(
                children: [
                  contain(
                    userid: datacollected!["userId"],
                    id: datacollected!["id"],
                    title: datacollected!["title"],
                  ),
                ],
              ),
            )
          : Expanded(child: Text("loading")),
    );
  }
}
