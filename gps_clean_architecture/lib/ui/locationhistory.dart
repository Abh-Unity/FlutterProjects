import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_clean_architecture/Services/statemanagement.dart';
import 'package:gps_clean_architecture/ui/recordcontainer.dart';

class locationhistory extends StatefulWidget {
  const locationhistory({super.key});

  @override
  State<locationhistory> createState() => _locationhistoryState();
}

class _locationhistoryState extends State<locationhistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Location History",
          style: TextStyle(fontFamily: "Fredoka One"),
        ),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          BlocBuilder<location, historystate>(
            builder: (context, state) {
              if (state is initialscreen) {
                return Text(
                  state.initialmessage,
                  style: TextStyle(fontFamily: "Fredoka One"),
                );
              } else if (state is displayrecord) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: state.data.length,
                    itemBuilder: (context, index) => recordcontainer(
                      longitude: state.data[index]!.Longitude,
                      latitude: state.data[index]!.Latitude,
                      altitude: state.data[index]!.Altitude,
                      timestamp: state.data[index]!.timestamp,
                    ),
                  ),
                );
              } else if (state is emptydata) {
                return Center(
                  child: Text(
                    state.emptymessage,
                    style: TextStyle(fontFamily: "Fredoka One"),
                  ),
                );
              } else {
                return Center(
                  child: Text(
                    "an unexpected error occured please contact the developer at ....@gmail.com and do give context if possible.",
                    style: TextStyle(fontFamily: "Fredoka One"),
                  ),
                );
              }
            },
          ),
          Text(
            "Please wait for atleast 1 minute in total after starting the gps tracking\nfor the app to run as intended.",
            textAlign: .center,
            style: TextStyle(fontFamily: "Fredoka One"),
          ),
          SizedBox(height: 60),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.read<location>().add(locationrecord());
        },
        child: BlocBuilder<location, historystate>(
          builder: (context, state) {
            return Text("Fetch", style: TextStyle(fontFamily: "Fredoka One"));
          },
        ),
      ),
    );
  }
}
