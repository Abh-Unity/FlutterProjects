import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class Textcubit extends Cubit<Textstate> {
  Textcubit(super.initialState);

  void settext() async {
    var req = await Uri.parse("https://jsonplaceholder.typicode.com/users/1");

    try {
      var res = await http.get(req).timeout(const Duration(seconds: 2));
      if (res.statusCode == 200) {
        Map<dynamic, dynamic> respondedData = jsonDecode(res.body);
        emit(Textstate(data: respondedData));
      } else {
        throw "error fetching the data.";
      }
    } catch (e) {
      emit(Textstate(message: "no internet connection"));
    }
  }
}

class Textstate {
  final String? message;
  final Map<dynamic, dynamic>? data;

  Textstate({this.data, this.message});
}
