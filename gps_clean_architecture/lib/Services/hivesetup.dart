import 'package:gps_clean_architecture/data/hold_data.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import '../Services/locator.dart';

Future<void> Hivesetup() async {
  Hive.registerAdapter(holddataAdapter());
  Box<hold_data> box = await Hive.openBox<hold_data>("box");
  sl.registerSingleton<Box<hold_data>>(box, instanceName: "box");
  Box<String> holduniqueid = await Hive.openBox("idcontainer");
  sl.registerSingleton<Box<String>>(holduniqueid, instanceName: "idcontainer");
}
