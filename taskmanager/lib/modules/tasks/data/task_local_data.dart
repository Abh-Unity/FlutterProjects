import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:hive_ce/hive_ce.dart';

import '../../../main.dart';

part 'task_local_data.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  final int? index;
  @HiveField(3)
  bool iscomplete;
  @HiveField(4)
  bool ispending;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    this.index,
    this.iscomplete = false,
    this.ispending = false,
  });

  factory TaskModel.fromJson(Map<String, dynamic> data) {
    return TaskModel(
      id: data['id'] as String,
      title: data['title'] as String,
      description: data['description'] as String,
      iscomplete: false,
      ispending: false,
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
