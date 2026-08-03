import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/core/routes/app_router.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive_ce.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final getit = GetIt.instance;
final newtask = 0;
final inprogress = 0;
final completed = 0;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskModelAdapter());
  final Box<TaskModel> box = await Hive.openBox<TaskModel>("mybox");
  final Box settingsbox = await Hive.openBox("loadsettings");
  getit.registerSingleton<int>(newtask, instanceName: "newtask");
  getit.registerSingleton<int>(inprogress, instanceName: "progresstask");
  getit.registerSingleton<int>(completed, instanceName: "completedtask");
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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
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
        backgroundColor: Color(0xFF17152D),
        foregroundColor: Colors.white,
      ),
      body: Container(
        width: 402,
        height: 874,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment(0.50, -0.00),
            end: Alignment(0.50, 1.00),
            colors: [const Color(0xFF17152D), const Color(0xFF532BDC)],
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 91,
              top: 349,
              child: Container(
                width: 220,
                height: 54,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 98,
              top: 360,
              child: GestureDetector(
                onTap: () async {
                  context.push('/dashboard');
                },
                child: SizedBox(
                  width: 213,
                  height: 54,
                  child: Text(
                    'Go To Dashboard ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w800,
                      letterSpacing: -0.60,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
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
