import 'package:flutter/material.dart';
import 'package:flutterapp/notescreate.dart';
import 'main.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class Cards extends StatefulWidget {
  final int? index;
  final Function? delete;
  final Function? edit;

  const Cards({super.key, this.index, this.delete, this.edit});

  @override
  State<Cards> createState() => _cardState();
}

class _cardState extends State<Cards> {
  @override
  Widget build(BuildContext context) {

    var Notes = box.getAt(widget.index!);
    return Slidable(
      endActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) {
              widget.delete!(widget.index);
            },
            icon: Icons.delete,
          ),
        ],
      ),
      startActionPane: ActionPane(
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (context) => notes()));
              setState(() {});
              widget.edit!(widget.index);
            },
            icon: Icons.edit,
          ),
        ],
      ),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white),
        ),
        child: Column(
          spacing: 8,
          children: [
            Text(
              Notes["title"],
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              Notes["Description"],
              style: TextStyle(color: Colors.white),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
