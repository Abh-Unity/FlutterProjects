import 'package:hive_ce/hive.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

extension HiveRegistrar on HiveInterface {
  void registerAdapters() {
    registerAdapter(TaskModelAdapter());
  }
}
