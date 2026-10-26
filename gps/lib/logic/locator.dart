import 'package:get_it/get_it.dart';
import 'package:gps/logic/hivesetup.dart';
import 'package:gps/logic/statemanagement.dart';
import 'package:hive_ce/hive.dart';

final sl = GetIt.instance;

void setup() async {
  sl.registerLazySingleton<handlegps>(() => handlegps());
  sl.registerLazySingleton<startbutton>(() => startbutton());
}
