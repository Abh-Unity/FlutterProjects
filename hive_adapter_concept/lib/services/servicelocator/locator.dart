import 'package:get_it/get_it.dart';
import 'package:hive_adapter_concept/services/data/Repository.dart';
import 'package:hive_adapter_concept/services/server/httpfetch.dart';

final sl = GetIt.instance;

void ServiceLocator() {
  sl.registerLazySingleton<Httpfetch>(() => Httpfetch());
  sl.registerLazySingleton<UserDataRepository>(
    () => UserDataRepository(http: sl<Httpfetch>()),
  );
}
