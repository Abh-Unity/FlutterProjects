import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps/logic/statemanagement.dart';
import 'package:hive_ce/hive.dart';
import 'package:hive_ce_flutter/adapters.dart';
import '../logic/locator.dart';
import 'ui/homepage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setup();
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
      home: MultiBlocProvider(
        providers: [
          BlocProvider<handlegps>(create: (context) => sl<handlegps>()),
          BlocProvider<startbutton>(create: (context) => sl<startbutton>()),
        ],
        child: Homepage(),
      ),
    );
  }
}
