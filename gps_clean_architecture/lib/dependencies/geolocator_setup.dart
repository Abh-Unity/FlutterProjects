import 'package:permission_handler/permission_handler.dart';

class setup {
  Future<bool?> geolocator_setup() async {
    var location = await Permission.location.status;
    var permission = await Permission.locationWhenInUse.request();
    if (permission.isGranted) {
      var locationalways = await Permission.locationAlways.request();
      var notification = await Permission.notification.request();
      if (locationalways.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return null;
    }
  }
}
