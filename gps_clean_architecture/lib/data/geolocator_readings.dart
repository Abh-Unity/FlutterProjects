import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_android/geolocator_android.dart';
import 'package:gps_clean_architecture/data/hold_data.dart';
import 'package:gps_clean_architecture/dependencies/geolocator_setup.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class geolocation {
  final setup locationaccess;
  final Box<hold_data> box;

  geolocation({required this.locationaccess, required this.box});

  /*i had to do it like this because if i didnt when everything was cramped inside of
* one single function there was no way for me to pause or do anything specific with the
* stream because i could call only one thing and that was location() and when i did
* every piece of code in that function would run so my app instead of user deciding to
* start or stop it didnt have the functionality of stopping and would automatically start
* when the app was opened*/

  /*so to counterract this i thought i should separate the stream subscrition and bring
  * it outside of function cause the scope of anything outside the function but
  * inside the same class can be accessed globally inside that class by any function
  * but since it used userrepo i couldnt simply put it outside the function and directly
  * inside of class because in dart if anything is inside of a normal function it would
  * gurantee that the class instance has been created and then i am accessing the function
  * and when the instance of the class is created the constructor injection runs first
  * before anything else(this is how it gurantees that the dependencies have been
  * initialized
  * since it didnt let me do it i figured if i create a late getcontinuouslocation
  * and run the runstream it would initialize getcontinuouslocation first
  * then when i need to i can pause or resume the getcontinuouslocation stream from
  * another function inside of the class cause late getcontinuouslocation
  * has class wide scope and if its the same thing that the functions are controlling
  * or using essentially i am getting the same instance of the object inside of two
  * different functions and since i did the late init,by the time i use the userdata
  * the class instance would have already been created with the required dependencies
  * injected(a regular function cannot be accessed without creating the instance/object
  * of the class))*/

  LocationSettings locationSettings = AndroidSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 10,
    foregroundNotificationConfig: ForegroundNotificationConfig(
      notificationTitle: "Currently Tracking",
      notificationText: "accuracy=${LocationAccuracy.values}",
    ),
  );

  Stream<Position> get getcontinuousLocation {
    Geolocator.getCurrentPosition();
    return Geolocator.getPositionStream(locationSettings: locationSettings);
  }

  void status() {
    StreamSubscription<Position> pos = getcontinuousLocation.listen(
      (Position position) {},
    );
  }
}
