import 'package:hive_ce/hive.dart';
import 'package:uuid/uuid.dart';

class deviceid {
  final Box<String> box;

  deviceid({required this.box});

  Future<String?> resolvedeviceinfo() async {
    var devinfo = Uuid();
    if (box.isEmpty) {
      String devid = devinfo.v4();
      await box.put("deviceid", devid);
      print("the device id is:");
      return devid;
    } else {
      var id = box.get("deviceid");
      print("the device already has deviceid${id}");
      return box.get("deviceid");
    }
  }
}
