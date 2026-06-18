import 'package:flutter/material.dart';
import 'package:torch_light/torch_light.dart';

void main() {
  runApp(const Home());
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
        useMaterial3: true,
      ),
      home: const Homepage(),
    );
  }
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  bool torchOn = false;
  late String torchtext;
  String onstate = "Turn Off The Flash";
  String offstate = "Turn On The Flash";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Flash", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: Column(
        children: [
          SizedBox(height: 50),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 90, horizontal: 17),
            child: Text(
              torchOn
                  ? "CLICK ON THE BUTTON BELOW TO TURN THE FLASH OFF."
                  : "CLICK ON THE BUTTON BELOW TO TURN THE FLASH ON.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: torchOn ? Colors.black : Colors.white,
              ),
            ),
          ),
          OutlinedButton(
            onPressed: () {
              turnFlashOn();
              setState(() {
                torchOn = !torchOn;
              });
            },
            child: torchOn ? Text(onstate) : Text(offstate),
          ),
        ],
      ),
      backgroundColor: torchOn ? Colors.white : Colors.black,
    );
  }

  Future<void> turnFlashOn() async {
    debugPrint("turnFlashOn method is running.");
    bool available = await TorchLight.isTorchAvailable();
    try {
      if (available) {
        if (!torchOn) {
          await TorchLight.disableTorch();
        } else {
          await TorchLight.enableTorch();
        }
      } else {
        throw "torch isn't available";
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), duration: Duration(seconds: 3)),
      );
    }
  }
}
