import 'dart:async';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:gps_clean_architecture/Services/talktoserver.dart';
import 'package:gps_clean_architecture/data/dataRepository.dart';
import 'package:gps_clean_architecture/data/deviceinfo.dart';
import 'package:gps_clean_architecture/data/geolocator_readings.dart';
import 'package:gps_clean_architecture/data/retrieveddataclass.dart';
import 'package:gps_clean_architecture/dependencies/geolocator_setup.dart';

final sl = GetIt.instance;

Future<void> dependency() async {
  sl.registerLazySingleton<setup>(() => setup());

  sl.registerLazySingleton<geolocation>(
    () => geolocation(
      locationaccess: sl<setup>(),
      box: sl.get(instanceName: "box"),
    ),
  );

  sl.registerLazySingleton<deviceid>(
    () => deviceid(box: sl.get(instanceName: "idcontainer")),
  );

  sl.registerLazySingleton<Userrepository>(
    () => Userrepository(
      id: sl<deviceid>(),
      backend: sl<talkToBackend>(),
      box: sl.get(instanceName: "box"),
      geo: sl<geolocation>(),
    ),
  );
  sl.registerLazySingleton<talkToBackend>(
    () => talkToBackend(
      idcontainer: sl.get(instanceName: "idcontainer"),
      box: sl.get(instanceName: "box"),
      dio: sl<Dio>(),
    ),
  );
  sl.registerLazySingleton<Dio>(
    () => Dio(
      BaseOptions(
        baseUrl: "https://flutterprojects.onrender.com",
        contentType: 'application/json',
      ),
    ),
  );
}
