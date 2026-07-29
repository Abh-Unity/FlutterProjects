import 'package:flutter/material.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';

class example extends StatefulWidget {
  final List<TaskModel> list;

  const example({super.key, required this.list});

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("lists")),
      body: ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (context, index) => Container(
          child: Column(
            children: [
              Text(widget.list[index].id.toString()),
              Text(widget.list[index].title.toString()),
              Text(widget.list[index].description.toString()),
            ],
          ),
        ),
      ),
    );
  }
}
