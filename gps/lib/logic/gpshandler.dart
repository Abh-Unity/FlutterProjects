import 'dart:async';
import 'dart:ffi';
import 'package:geolocator/geolocator.dart';
import 'package:gps/logic/statemanagement.dart';
import 'package:hive_ce/hive.dart';
import 'package:permission_handler/permission_handler.dart' hide ServiceStatus;

import 'locator.dart';

final LocationSettings locationSettings = AndroidSettings(
  accuracy: LocationAccuracy.high,
  foregroundNotificationConfig: ForegroundNotificationConfig(
    notificationTitle: "running in the background",
    notificationText: "current location",
    enableWakeLock: true,
  ),
);

StreamSubscription<Position> positionstream =
    Geolocator.getPositionStream(locationSettings: locationSettings).listen((
      Position currentpos,
    ) {
      sl<handlegps>().add(coordinates(gpspos: currentpos));
    });

Future<void> gpsenabled(bool ispaused) async {
  late PermissionStatus alwaysaccess;
  var status = await Permission.locationAlways.status;
  status = await Permission.locationWhenInUse.request();
  if (status.isDenied) {
    while (status.isDenied) {
      status = await Permission.locationWhenInUse.request();
    }
  } else if (status.isLimited) {
  } else if (status.isGranted) {
    alwaysaccess = await Permission.locationAlways.request();
    await Permission.notification.request();
    if (!alwaysaccess.isGranted) {
      sl<handlegps>().add(alwaysallowerror());
    }
  } else if (status.isPermanentlyDenied) {}

  try {
    if (alwaysaccess.isGranted && ispaused == true) {
      positionstream.resume();
    } else if (ispaused == false) {
      positionstream.pause();
      sl<handlegps>().add(paused());
    }
  } catch (e) {
    throw Exception("$e");
  }
}
