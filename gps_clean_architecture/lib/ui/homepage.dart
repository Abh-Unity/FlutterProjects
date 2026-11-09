import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gps_clean_architecture/Services/statemanagement.dart';
import 'package:gps_clean_architecture/dependencies/geolocator_setup.dart';
import 'package:gps_clean_architecture/ui/longitudecontainer.dart';
import '../Services/locator.dart';
import '../data/geolocator_readings.dart';

class MyHomePage extends StatefulWidget {
  final title;
  final geolocation gpsread;

  const MyHomePage({super.key, required this.title, required this.gpsread});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool starttracking = true;

  @override
  void initState() {
    setup().geolocator_setup();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 3,
        child: Column(
          children: [
            SizedBox(height: 100),
            Text(
              "Options",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontSize: 45,
                fontFamily: "Fredoka One",
              ),
            ),
            SizedBox(height: 10),
            Container(
              height: 2,
              width: 280,
              color: Theme.of(context).colorScheme.onPrimary,
            ),
            SizedBox(height: 10),
            ListTile(
              title: Text(
                "Location History",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onPrimary,
                  fontSize: 20,
                  fontFamily: "Fredoka One",
                ),
              ),
              onTap: () {
                context.push("/location");
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text(widget.title, style: TextStyle(fontFamily: "Fredoka One")),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: BlocBuilder<handlegps, statemanager>(
        builder: (context, state) {
          if (state is dataholder) {
            return containCoords(
              Longitude: state.data.Longitude,
              Latitude: state.data.Latitude,
              Altitude: state.data.Altitude,
            );
          } else if (state is initialstate) {
            return Center(
              child: Text(
                state.message,
                style: TextStyle(fontFamily: "Fredoka One"),
              ),
            );
          } else if (state is nokey) {
            return Center(
              child: Text(
                state.errormessage,
                style: TextStyle(fontFamily: "Fredoka One"),
              ),
            );
          } else if (state is stopmessage) {
            return Center(
              child: Text(
                state.stopmsg,
                style: TextStyle(fontFamily: "Fredoka One"),
              ),
            );
          } else {
            return Center(
              child: Text(
                "loading",
                style: TextStyle(fontFamily: "Fredoka One"),
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (starttracking) {
            starttracking = false;
            context.read<handlegps>().add(handle());
          } else {
            starttracking = true;
            context.read<handlegps>().add(stop());
          }
        },
        child: BlocBuilder<handlegps, statemanager>(
          builder: (context, state) {
            if (state is dataholder) {
              return Text("stop", style: TextStyle(fontFamily: "Fredoka One"));
            } else if (state is stopmessage) {
              return Text("start", style: TextStyle(fontFamily: "Fredoka One"));
            } else {
              return Text("start", style: TextStyle(fontFamily: "Fredoka One"));
            }
          },
        ),
      ),
    );
  }
}
