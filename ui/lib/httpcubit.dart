import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class textcubit extends Cubit<Textstate> {
  textcubit(super.initialState);

  void settext() async {
    var request = await Uri.parse(
      "https://air-quality-api.open-meteo.com/v1/air-quality?latitude=27.70&longitude=85.32&current=us_aqi",
    );
    var respond = await http.get(request);
    try {
      if (respond.statusCode == 200) {
        Map<dynamic, dynamic> respondedmsg = jsonDecode(respond.body);
        var reqtemp = await Uri.parse(
          "https://api.open-meteo.com/v1/forecast?latitude=27.70&longitude=85.32&current=temperature_2m&timezone=auto",
        );
        var restemp = await http.get(reqtemp);
        var respondtemp = jsonDecode(restemp.body);

        emit(Textstate(weathercondition: respondedmsg, temp: respondtemp));
      } else {
        throw "error";
      }
    } catch (e) {}
  }
}

class Textstate {
  Map<dynamic, dynamic>? weathercondition;
  Map<dynamic, dynamic>? temp;

  Textstate({this.weathercondition, this.temp});
}
