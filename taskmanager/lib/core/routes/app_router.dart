import 'package:go_router/go_router.dart';
import 'package:taskmanager/egfile.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

List<TaskModel> list = getit<List<TaskModel>>();
final GoRouter myroute = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => DashboardPage()),
    GoRoute(
      path: '/example',
      builder: (context, state) {
        return example(list: list);
      },
    ),
  ],
);
