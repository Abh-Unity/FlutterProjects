import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:taskmanager/edit_task.dart';
import 'package:taskmanager/modules/tasks/data/task_local_data.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'main.dart';

class example extends StatefulWidget {
  const example({super.key});

  @override
  State<example> createState() => _exampleState();
}

class _exampleState extends State<example> {
  final Box<TaskModel> box = getit<Box<TaskModel>>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("lists"),
        actions: [
          Text(
            "Total task:${box.length}",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
        foregroundColor: Colors.black,
      ),
      body: MasonryGridView.builder(
        gridDelegate: SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: box.length,
        itemBuilder: (context, index) {
          return Slidable(
            startActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  onPressed: (context) {
                    Box<TaskModel> box = getit<Box<TaskModel>>();
                    box.deleteAt(index);
                    setState(() {});
                  },
                  backgroundColor: Colors.green.shade50,
                  icon: Icons.delete,
                  label: 'Delete',
                ),
              ],
            ),
            endActionPane: ActionPane(
              motion: StretchMotion(),
              children: [
                SlidableAction(
                  borderRadius: BorderRadius.all(Radius.circular(3)),
                  onPressed: (context) {
                    context.push("/edit", extra: index);
                    loadfield(index);
                  },
                  backgroundColor: Colors.green.shade50,
                  icon: Icons.edit,
                  label: "Edit",
                ),
              ],
            ),
            child: Card(
              child: Column(
                children: [
                  Text(box.getAt(index)!.id, overflow: TextOverflow.ellipsis),
                  Text(
                    box.getAt(index)!.title,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    box.getAt(index)!.description,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push("/edit");
          resetcontrollers();
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
