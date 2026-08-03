import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive_ce.dart';

part 'task_local_data.g.dart';

@HiveType(typeId: 0)
class TaskModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  final int? index;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.index,
  });

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
    return tasks;
  } catch (error) {
    return [];
  }
}
