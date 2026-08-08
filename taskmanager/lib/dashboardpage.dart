import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';
import 'main.dart';
import 'package:fl_chart/fl_chart.dart';

class dash extends StatefulWidget {
  const dash({super.key});

  @override
  State<dash> createState() => _dashState();
}

class _dashState extends State<dash> {
  @override
  Widget build(BuildContext context) {
    final box = getit<Box<TaskModel>>();
    final total = box.length;
    int completed = box.values.where((t) => t.iscomplete).length;
    int pending = box.values.where((t) => t.ispending).length;
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        elevation: 3,
        backgroundColor: Color(0xffecd6d6),
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
            ],
          ),
        ),
      ),
      body: Container(
        width: 402,
        height: 874,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: const Color(0xFFF5EDED)),
        child: Stack(
          children: [
            Positioned(
              left: 11,
              top: 56,
              child: GestureDetector(
                onTap: () {
                  context.push("/example");
                },
                child: Container(
                  width: 190,
                  height: 165,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 53,
              top: 89,
              child: Text(
                'Total Tasks',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 226,
              top: 71,
              child: Text(
                'Total Tasks',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 113,
              top: 230,
              child: GestureDetector(
                onTap: () {
                  context.push("/completed");
                },
                child: Container(
                  width: 191,
                  height: 166,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 209,
              top: 56,
              child: GestureDetector(
                onTap: () {
                  context.push("/inprogress");
                },
                child: Container(
                  width: 190,
                  height: 165,
                  decoration: ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(26),
                    ),
                    shadows: [
                      BoxShadow(
                        color: Color(0x3F000000),
                        blurRadius: 4,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 13,
              top: 453,
              child: Container(
                width: 381,
                height: 318,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(side: BorderSide(width: 1)),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    ),
                  ],
                ),
                child: charts(),
              ),
            ),
            Positioned(
              left: 263,
              top: 89,
              child: Text(
                'Pending ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 159,
              top: 260,
              child: Text(
                'Completed',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 82,
              top: 143,
              child: SizedBox(
                width: 48,
                height: 44,
                child: Text(
                  box.length.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 285,
              top: 143,
              child: SizedBox(
                width: 48,
                height: 44,
                child: Text(
                  pending.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 190,
              top: 319,
              child: SizedBox(
                width: 48,
                height: 44,
                child: Text(
                  completed.toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 36,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ),
            Positioned(
              left: 161,
              top: 588,
              child: Text(
                "${task.toStringAsFixed(1)}%",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Positioned(
              left: 125,
              top: 424,
              child: Row(
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.deepPurple,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Complete"),

                  const SizedBox(width: 20),

                  Container(
                    width: 12,
                    height: 12,
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text("Incomplete"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  late double task;

  Widget charts() {
    final Box totalbox = getit<Box<TaskModel>>();
    final int comtask = totalbox.values.where((t) => t.iscomplete).length;
    final int total = getit<Box<TaskModel>>().length;
    int lefttask = total - comtask;
    task = comtask / (comtask + lefttask) * 100;
    return PieChart(
      PieChartData(
        sections: [
          PieChartSectionData(
            value: comtask.toDouble(),
            title: "",
            color: Colors.deepPurple,
            titleStyle: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          PieChartSectionData(
            value: lefttask.toDouble(),
            title: "",
            color: Colors.grey,
            titleStyle: TextStyle(
              color: Colors.deepPurple,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
