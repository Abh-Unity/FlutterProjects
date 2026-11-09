import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gps_clean_architecture/Services/hivesetup.dart';
import 'package:gps_clean_architecture/Services/statemanagement.dart';
import 'package:gps_clean_architecture/data/dataRepository.dart';
import 'package:gps_clean_architecture/data/deviceinfo.dart';
import '../Services/locator.dart';
import 'go_router.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hivesetup();
  await dependency();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          handlegps(datarepo: sl<Userrepository>(), androidid: sl<deviceid>()),
      child: MaterialApp.router(
        routerConfig: router,
        debugShowCheckedModeBanner: false,

        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: .fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
