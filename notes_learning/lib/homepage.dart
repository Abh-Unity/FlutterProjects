import 'package:flutter/material.dart';
import 'package:hive_ce/hive.dart';

class Homepage extends StatefulWidget {
  Map? note;
  int? index;

  Homepage({super.key, this.note, this.index});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _box = Hive.box("MY_BOX");

  TextEditingController controller0 = TextEditingController();

  TextEditingController controller1 = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller0.text = widget.note?["title"] ?? "";
    controller1.text = widget.note?["description"] ?? "";
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new note.", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pop();
              save();
            },
            icon: Icon(Icons.done),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          TextField(
            controller: controller0,
            maxLines: null,
            style: TextStyle(color: Colors.white, fontSize: 30),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              hintStyle: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: TextField(
              controller: controller1,
              style: TextStyle(fontSize: 20, color: Colors.white),
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Describe your story.",
                hintStyle: TextStyle(color: Colors.white, fontSize: 20),
              ),
              maxLines: null,
            ),
          ),
        ],
      ),
    );
  }

  void save() {
    if (widget.index != null) {
      _box.putAt(widget.index!, {
        "title": controller0.text,
        "description": controller1.text,
      });
    } else {
      _box.add({"title": controller0.text, "description": controller1.text});
    }
  }
}
