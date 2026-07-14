import 'package:flutter/material.dart';
import 'actualhome.dart';
import 'actualhome.dart';

Future<void> main() async {
  runApp(homepage());
}
class homepage extends StatelessWidget {
  const homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.white)),
      home: Myhome(),
    );
  }
}

