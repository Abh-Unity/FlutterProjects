import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/routes/app_router.dart';
import 'package:taskmanager/dashboardpage.dart';
import 'package:taskmanager/egfile.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final getit = GetIt.instance;
final inprogress = false;
final completed = false;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  final Box<TaskModel> box = await Hive.openBox<TaskModel>("mybox");
  final Box settingsbox = await Hive.openBox("loadsettings");
  getit.registerSingleton<bool>(inprogress, instanceName: "ispending");
  getit.registerSingleton<bool>(completed, instanceName: "iscompleted");
  GetIt.instance.registerSingleton<Box<TaskModel>>(box);
  getit.registerFactory<Future<List<TaskModel>> Function()>(() => readjson);
  setup();
  final hasrun = settingsbox.get("has initialized", defaultValue: false);
  await getit.allReady();
  if (!hasrun) {
    loadtask();
    settingsbox.put("has initialized", true);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink.shade300),
        useMaterial3: true,
      ),
      routerConfig: myroute,
    );
  }
}

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Task Manager"),
        backgroundColor: Colors.deepPurple.shade300,
        foregroundColor: Colors.white,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.deepPurple.shade300,
          child: ListView(
            children: [
              DrawerHeader(
                child: Center(
                  child: Text("Options", style: TextStyle(fontSize: 40)),
                ),
              ),
              ListTile(
                title: Text("Completed Tasks"),
                onTap: () {
                  context.push("/completed");
                },
              ),
              ListTile(
                title: Text("In-Progress Tasks"),
                onTap: () {
                  context.push("/inprogress");
                },
              ),
              ListTile(
                title: Text("Settings"),
                onTap: () {
                  context.push("settings");
                },
              ),
            ],
          ),
        ),
      ),
      body: example(),
    );
  }
}

void setup() {
  getit.registerSingletonAsync<List<TaskModel>>(() async {
    final tasks = getit<Future<List<TaskModel>> Function()>();
    List<TaskModel> lists = await tasks();
    return lists;
  });
}

void loadtask() {
  final Box num = getit<Box<TaskModel>>();
  final List<TaskModel> list = getit<List<TaskModel>>();
  for (int i = 0; i < list.length; i++) {
    num.add(
      TaskModel(
        id: list[i].id,
        title: list[i].title,
        description: list[i].description,
      ),
    );
  }
}
