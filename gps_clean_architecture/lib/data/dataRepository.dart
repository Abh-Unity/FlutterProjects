import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:gps_clean_architecture/Services/talktoserver.dart';
import 'package:gps_clean_architecture/data/geolocator_readings.dart';
import 'package:gps_clean_architecture/data/retrieveddataclass.dart';
import 'package:hive_ce/hive_ce.dart';

import 'hold_data.dart';

class Userrepository {
  final Box<hold_data> box;
  final geolocation geo;
  final talkToBackend backend;
  final id;

  Userrepository({
    required this.box,
    required this.geo,
    required this.backend,
    required this.id,
  });

  /*here the decision is taken to whether to upload the data on to the cloud
  *or to store it in hive and then later upload into cloud depending upon the
  * availability of internet connection*/

  hold_data get_data(Position pos, String id, DateTime date) {
    hold_data data = hold_data.fromgps(pos, id, date);
    return data;
  }

  Future<void> registerdataontobox(hold_data preppedData) async {
    await box.add(preppedData);
    backend.datatojson();
    print("added to the box successfully");
  }

  Future<List<retrieved_data>?> getdatafromserver() async {
    try {
      List<dynamic>? data = await backend.getdata();
      List<retrieved_data> datalist = data!
          .map((singlemap) => retrieved_data.frombackend(singlemap))
          .toList();
      return datalist;
    } catch (e) {
      return null;
    }
  }
}
