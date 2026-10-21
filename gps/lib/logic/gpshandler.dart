import 'dart:async';
import 'dart:ffi';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;

Future<Position> gpsenabled() async {
  final LocationSettings locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,

    foregroundNotificationConfig: ForegroundNotificationConfig(
      notificationTitle: "running in the background",
      notificationText: "current location",
      enableWakeLock: true,
    ),
  );

  late var alwaysaccess;
  var status = await Permission.locationAlways.status;
  status = await Permission.locationWhenInUse.request();
  if (status.isDenied) {
    while (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }
  } else if (status.isLimited) {
    print("////////////////////////location is limited");
  } else if (status.isGranted) {
    alwaysaccess = await Permission.locationAlways.request();
    print("///////////////////////location granted");
  } else if (status.isPermanentlyDenied) {
    print(
      "////////////////////////the app cannot function without location access",
    );
  }
  var currentpos = await Geolocator.getCurrentPosition(
    locationSettings: locationSettings,
  );
  Geolocator.getServiceStatusStream().listen((ServiceStatus status) {
    if (status == ServiceStatus.enabled) {
      StreamSubscription<Position> positionstream =
          Geolocator.getPositionStream(
            locationSettings: locationSettings,
          ).listen((Position? currentpos) {
            print(
              currentpos == null
                  ? 'Unknown'
                  : 'LATITUDE:${currentpos.latitude.toString()}, LONGITUDE${currentpos.longitude.toString()}',
            );
          });
    }
  });

  await Permission.notification.request();

  return currentpos;
}
