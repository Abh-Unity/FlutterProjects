import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weatherapp/datacontainer.dart';

class fetch extends StatefulWidget {
  fetch({super.key});

  @override
  State<fetch> createState() => _fetchState();
}

Map<dynamic, dynamic>? data;

class _fetchState extends State<fetch> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather of kathmandu"),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      body: data == null
          ? Text("data isnt available right now.")
          : datacontain(
              elevation: data!["elevetion"],
              latitude: data!["latitude"],
              longitude: data!["longitude"],
              temperature: data!["current"]["temperature_2m"],
              timezone: data!["timezone"],
            ),
    );
  }
}

Future<void> fetchweather() async {
  try {
    final request = await Uri.parse(
      "https://api.open-meteo.com/v1/forecast?latitude=27.7172&longitude=85.3240&current=temperature_2m",
    );
    final response = await http.get(request);
    if (response.statusCode == 200) {
      Map<dynamic, dynamic> respondedMessage = jsonDecode(response.body);
      data = respondedMessage;
    } else {
      throw "unable to fetch the data from the internet please try again later.";
    }
  } catch (e) {
    print(e);
  }
}
