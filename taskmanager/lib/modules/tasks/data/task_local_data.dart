import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TaskModel {
  final String id;
  final String title;
  final String description;

  TaskModel({required this.id, required this.title, required this.description});

  factory TaskModel.fromJson(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
    );
  }
}

Future<List<TaskModel>> readjson() async {
  try {
    var response = await rootBundle.loadString("assets/data/task.json");
    var respond = jsonDecode(response) as List;
    final List<TaskModel> tasks = respond
        .map((e) => TaskModel.fromJson(e as Map<String, dynamic>))
        .toList();
    print("task length is: ${tasks.length}");
    return tasks;
  } catch (error) {
    print(Text("ttask failed***********" + error.toString()));
    return [];
  }
}
