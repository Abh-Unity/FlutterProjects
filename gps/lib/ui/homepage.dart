import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps/logic/gpshandler.dart';
import 'package:gps/logic/statemanagement.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

bool showsnackbar = false;
bool ispaused = false;

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Gps")),
      body: Align(
        alignment: .center,
        child: Column(
          children: [
            BlocBuilder<handlegps, handlestate>(
              builder: (context, state) {
                if (state is passcoordinates) {
                  return Card(
                    child: Text(
                      "Longitude:${state.gpsposition.longitude},Latitude:${state.gpsposition.latitude}?,Altitude:${state.gpsposition.altitude}",
                    ),
                  );
                } else if (state is initmessage) {
                  return Text(state.initialmessage);
                } else if (state is allwaysallowfinal) {
                  return Text(state.finalmessage);
                } else if (state is pausedmessage) {
                  return Text("${state.message},\nPAUSED");
                } else {
                  return Text("error");
                }
              },
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ispaused = !ispaused;
          gpsenabled(ispaused);
          context.read<startbutton>().add(buttoncontents());
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("loading"), duration: Duration(seconds: 1)),
          );
        },
        child: BlocBuilder<startbutton, String>(
          builder: (context, state) {
            return Text("$state");
          },
        ),
      ),
    );
  }
}
