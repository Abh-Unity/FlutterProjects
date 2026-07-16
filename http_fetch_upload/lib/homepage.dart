import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http_fetch_upload/nextpg.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("get list"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 300,
            child: Align(
              alignment: Alignment(0, -0.3),
              child: Text(
                "hi there.please press the button down below to "
                "\nfetch a list of data through json's api",
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await datafetch();
              setState(() {});
            },
            child: Icon(Icons.download),
          ),
          data != null
              ? Expanded(
                  child: ListView.builder(
                    itemCount: data!.length,
                    itemBuilder: (context, index) =>
                        Nextpage(transferred_data: data!, index: index),
                  ),
                )
              : Text("PRESS THE BUTTON ABOVE TO FETCH A LIST OF DATA."),
        ],
      ),
    );
  }
}

List? data;

Future<void> datafetch() async {
  try {
    final request = Uri.parse("https://jsonplaceholder.typicode.com/users");
    var response = await http.get(request);
    List decodedData = jsonDecode(response.body);
    data = decodedData;
  } catch (e) {}
}
