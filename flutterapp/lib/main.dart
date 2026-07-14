import 'package:flutter/material.dart';
import 'package:flutterapp/cards.dart';
import 'package:flutterapp/notescreate.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("MY BOX");
  runApp(MyApp());
}

final box = Hive.box("MY BOX");

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      routes: {"/notes": (context) => notes()},
      debugShowCheckedModeBanner: false,
      title: "Notes",
      home: Builder(
        builder: (BuildContext context) {
          return Scaffold(
            appBar: AppBar(
              title: Text("Notes", style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              actions: [
                OutlinedButton.icon(
                  onPressed: () async {
                    await Navigator.pushNamed(context, "/notes");
                    setState(() {});
                  },
                  label: Icon(Icons.add),
                ),
              ],
            ),
            body: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 6,
                mainAxisSpacing: 6,
              ),

              itemCount: Hive.box("MY BOX").length,
              itemBuilder: (context, index) =>
                  Cards(index: index, delete: delete, edit: edit),
            ),
            backgroundColor: Colors.black,
          );
        },
      ),
    );
  }

  void edit(int index) {
    var notes = box.getAt(index);
    Titlecontroller.text = notes["title"];
    Descriptioncontroller.text = notes["Description"];
  }

  delete(int index) {
    box.deleteAt(index);
    setState(() {});
  }
}
