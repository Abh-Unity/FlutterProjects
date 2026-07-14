import 'package:flutter/material.dart';
import 'main.dart';


TextEditingController Titlecontroller = TextEditingController();
TextEditingController Descriptioncontroller = TextEditingController();

class notes extends StatefulWidget {
  final int? index;

  notes({super.key, this.index});

  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false,
        actions: [
          OutlinedButton.icon(
            onPressed: () {
              save();
              Navigator.of(context).pop();
              setState(() {});
            },
            label: Icon(Icons.done),
          ),
        ],
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        backgroundColor: Colors.black,
        title: Text("Add note", style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          TextField(
            controller: Titlecontroller,
            maxLines: null,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Title",
              hintStyle: TextStyle(color: Colors.white54),
            ),
            style: TextStyle(fontSize: 40, color: Colors.white),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: TextField(
              controller: Descriptioncontroller,
              maxLines: null,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Describe your story here.",
                hintStyle: TextStyle(color: Colors.white54),
              ),
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  void save() {
    if (widget.index! == null) {
      box.add({
        "title": Titlecontroller.text,
        "Description": Descriptioncontroller.text,
      });
    } else {
      box.putAt(widget.index!, {
        "title": Titlecontroller.text,
        "Description": Descriptioncontroller.text,
      });
    }
  }
}
