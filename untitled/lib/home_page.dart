import 'package:flutter/material.dart';
import 'package:untitled/learn_flutter.dart';

class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) {
                return LearnFlutterPage();
              },
            ),
          );
        },
        child: const Text("Show The Journey"),
      ),
    );
  }
}
