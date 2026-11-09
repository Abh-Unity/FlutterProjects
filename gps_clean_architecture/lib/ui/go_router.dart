import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:gps_clean_architecture/Services/statemanagement.dart';
import 'package:gps_clean_architecture/data/dataRepository.dart';
import 'package:gps_clean_architecture/data/geolocator_readings.dart';
import 'package:gps_clean_architecture/ui/homepage.dart';
import 'package:gps_clean_architecture/ui/locationhistory.dart';

import '../Services/locator.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) =>
          MyHomePage(title: "GPS", gpsread: sl<geolocation>()),
    ),
    GoRoute(
      path: "/location",
      builder: (context, state) => BlocProvider<location>(
        create: (context) => location(userrepo: sl<Userrepository>()),
        child: locationhistory(),
      ),
    ),
  ],
);
