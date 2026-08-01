import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:taskmanager/core/routes/app_router.dart';
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
      appBar: AppBar(
        title: Text("lists"),
        actions: [
          Text(
            "Total task:${list.length}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        foregroundColor: Colors.black,
      ),
      body: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: 8,
        itemBuilder: (context, index) => Card(
          child: Column(
            children: [
              Text(widget.list[index].id.toString()),
              Text(widget.list[index].title.toString()),
              Text(
                widget.list[index].description.toString(),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.add),
      ),
    );
  }
}
