import 'package:flutter/material.dart';
import 'package:gps/logic/gpshandler.dart';

import 'ui/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(home());
}

class home extends StatelessWidget {
  const home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.purple),
        useMaterial3: true,
      ),
      home: Homepage(),
    );
  }
}
