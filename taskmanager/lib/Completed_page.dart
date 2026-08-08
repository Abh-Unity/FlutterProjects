import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

import 'main.dart';

class Completepg extends StatefulWidget {
  const Completepg({super.key});

  @override
  State<Completepg> createState() => _completepgState();
}

class _completepgState extends State<Completepg> {
  final Box<TaskModel> box = getit<Box<TaskModel>>();

  @override
  Widget build(BuildContext context) {
    final List<TaskModel> completetask = box.values
        .where((t) => t.iscomplete)
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("Completed tasks"),
        backgroundColor: Colors.deepPurple.shade300,
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: completetask.length,
        itemBuilder: (context, index) {
          final task = completetask[index];
          return Slidable(
            startActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  onPressed: (context) {
                    completetask[index].delete();
                    setState(() {});
                  },
                  backgroundColor: Colors.purple.shade200,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: BoxBorder.all(color: Colors.black),
                ),
                child: Column(
                  children: [
                    Text(task.id, overflow: TextOverflow.ellipsis),
                    Text(task.title, overflow: TextOverflow.ellipsis),
                    Text(task.description, overflow: TextOverflow.ellipsis),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
