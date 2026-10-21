import 'package:hive/hive.dart';
import 'package:hive_adapter_concept/services/data/userdata.dart';
import 'package:hive_flutter/adapters.dart';

import '../servicelocator/locator.dart';

void HiveSetup() async {
  await Hive.initFlutter;
  var box = await Hive.openBox<userdata>("Box");
  sl.registerSingleton<Box<userdata>>(box, instanceName: "userdata");
}
