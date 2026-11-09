import "package:dio/dio.dart";
import "package:gps_clean_architecture/data/hold_data.dart";
import "package:hive_ce/hive.dart";

class talkToBackend {
  final Box<hold_data> box;
  final Box<String> idcontainer;
  final Dio dio;

  talkToBackend({
    required this.box,
    required this.dio,
    required this.idcontainer,
  });

  late var lastkey;
  late var data;

  Future<bool?> datatojson() async {
    List<hold_data> coordinates = box.values.toList();
    try {
      if (coordinates.isEmpty) {
        print("coordinates list is empty");
        return false;
      }
      final response = await dio.post("/api/v1/location", data: coordinates);
      if (response.statusCode == 200) {
        print("data uploaded to the server and clearing the box");
        await box.clear();
        return true;
      } else {
        return null;
      }
    } catch (e) {
      print(e);
    }
  }

  Future<List<dynamic>?> getdata() async {
    try {
      String Devid = await idcontainer.get("deviceid")!;
      var data = await dio.get(
        "/get/data",
        queryParameters: {"deviceid": Devid},
      );
      if (data.statusCode == 200) {
        var responded_Data = data.data;
        return responded_Data;
      } else {
        print(data.statusCode);
        return [];
      }
    } catch (e) {
      return null;
    }
  }
}
