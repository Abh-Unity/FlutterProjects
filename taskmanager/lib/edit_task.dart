import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_ce/hive.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

import 'main.dart';

class edittask extends StatefulWidget {
  final int? index;

  edittask({super.key, this.index});

  final Box<TaskModel> box = getit<Box<TaskModel>>();

  @override
  State<edittask> createState() => _edittaskState();
}

TextEditingController idcontroller = TextEditingController();
TextEditingController titlecontroller = TextEditingController();
TextEditingController descontroller = TextEditingController();

class _edittaskState extends State<edittask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: Text("Edit Task"),
        actions: [
          IconButton(
            onPressed: () {
              savetask();
              context.pop();
            },
            icon: Text("Save"),
          ),
          IconButton(
            onPressed: () {
              final index = widget.index;
              if (widget.index != null) {
                final Box<TaskModel> box = getit<Box<TaskModel>>();
                final task = box.getAt(index!)!;
                task.iscomplete = true;
                task.ispending = false;
                task.save();
              }
              context.pop();
            },
            icon: Text("Complete"),
          ),
          IconButton(
            onPressed: () {
              final index = widget.index;
              if (widget.index != null) {
                final Box<TaskModel> box = getit<Box<TaskModel>>();
                final task = box.getAt(index!)!;
                task.ispending = true;
                task.iscomplete = false;
                task.save();
              }
              context.pop();
            },
            icon: Text("is pending"),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 300,
              child: Card(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Enter the Task ID Below."),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 70,
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
              controller: idcontroller,
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 300,
              child: Card(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Enter the Task Title Below."),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
              controller: titlecontroller,
              maxLines: null,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              height: 30,
              width: 300,
              child: Card(
                child: Align(
                  alignment: Alignment.center,
                  child: Text("Enter the Task Description Below."),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 70,
            child: TextField(
              decoration: InputDecoration(border: InputBorder.none),
              controller: descontroller,
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }

  void savetask() {
    final Box<TaskModel> box = getit<Box<TaskModel>>();
    TaskModel task = TaskModel(
      id: idcontroller.text,
      title: titlecontroller.text,
      description: descontroller.text,
    );
    final index = widget.index;
    if (index == null) {
      if (idcontroller.text.isNotEmpty &&
          descontroller.text.isNotEmpty &&
          titlecontroller.text.isNotEmpty) {
        box.add(task);
      }
    } else {
      box.putAt(index, task);
    }
  }
}

void loadfield(int index) {
  final Box<TaskModel> box = getit<Box<TaskModel>>();
  final TaskModel task = box.getAt(index)!;
  idcontroller.text = task.id.toString();
  titlecontroller.text = task.title;
  descontroller.text = task.description;
}

void saveEditedTask(int index) {
  final Box<TaskModel> box = getit<Box<TaskModel>>();
  box.putAt(
    index,
    TaskModel(
      id: idcontroller.text,
      title: titlecontroller.text,
      description: descontroller.text,
    ),
  );
}

void resetcontrollers() {
  idcontroller.clear();
  titlecontroller.clear();
  descontroller.clear();
}
