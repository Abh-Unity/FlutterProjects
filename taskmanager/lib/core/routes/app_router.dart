import 'package:go_router/go_router.dart';
import 'package:taskmanager/Completed_page.dart';
import 'package:taskmanager/dashboardpage.dart';
import 'package:taskmanager/edit_task.dart';
import 'package:taskmanager/egfile.dart';
import 'package:taskmanager/settings.dart';
import 'package:taskmanager/in-progress_page.dart';
import 'package:taskmanager/main.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

List<TaskModel> list = getit<List<TaskModel>>();
final GoRouter myroute = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => dash()),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) {
        return dash();
      },
    ),
    GoRoute(path: "/example", builder: (context, state) => example()),
    GoRoute(
      path: "/edit",
      builder: (context, state) {
        final index = state.extra as int?;
        return edittask(index: index);
      },
    ),
    GoRoute(path: '/completed', builder: (context, state) => Completepg()),
    GoRoute(path: '/inprogress', builder: (context, state) => inprogresspg()),
    GoRoute(path: '/settings', builder: (context, state) => settings()),
  ],
);
