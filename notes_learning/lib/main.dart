import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import 'package:notes_learning/homepage.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("MY_BOX");

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  void delete(BuildContext context) {}

  void deletetask(int index) {
    setState(() {
      Hive.box("MY_BOX").deleteAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> notes = [];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {"/homepage": (context) => Homepage()},
      home: Builder(
        builder: (context) {
          void edit(BuildContext context) {}

          void editcontext(int index) async {
            print("editcontext called with index $index");
            var edittext = Hive.box("MY_BOX").getAt(index);
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Homepage(note: edittext, index: index),
              ),
            );
            setState(() {});
          }

          return Scaffold(
            appBar: AppBar(
              title: Text("Notes"),
              foregroundColor: Colors.white,
              backgroundColor: Colors.grey,
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 8.0,
                    ),
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisSpacing: 6,
                        crossAxisSpacing: 6,
                        crossAxisCount: 3,
                      ),
                      itemCount: Hive.box("MY_BOX").length,
                      itemBuilder: (context, index) {
                        delete(context) => deletetask(index);
                        edit(context) => editcontext(index);
                        final box = Hive.box("MY_BOX");
                        final note = box.getAt(index);
                        return Slidable(
                          endActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(
                                onPressed: delete,
                                icon: Icons.delete,
                              ),
                            ],
                          ),
                          startActionPane: ActionPane(
                            motion: StretchMotion(),
                            children: [
                              SlidableAction(onPressed: edit, icon: Icons.edit),
                            ],
                          ),
                          child: Container(
                            height: 150,
                            width: 200,
                            decoration: BoxDecoration(
                              border: BoxBorder.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              title: Text(
                                note["title"],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 23,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                note["description"],
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () async {
                await Navigator.pushNamed(context, "/homepage");
                setState(() {});
              },
              child: Icon(Icons.add),
            ),
            backgroundColor: Colors.black,
          );
        },
      ),
    );
  }
}
