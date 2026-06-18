import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController control = TextEditingController();
  late var Firstnum;
  late var calculatormode;
  late var c;
  String modetext = "";
  void _incrementCounter() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("Calculator"),
        actions: [
          Text(modetext),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Container(
                  margin: EdgeInsets.symmetric(vertical: 25),
                  child: TextField(controller: control, readOnly: true,style: TextStyle(fontSize: 25),),),
            ),
            SizedBox(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 50),
                child: SizedBox(
                  height: 500,
                  child: Row(
                    children: [
                      
                      Expanded(
                        child: GridView.count(
                          crossAxisCount: 5,
                          mainAxisSpacing: 4,
                          crossAxisSpacing: 4,
                          shrinkWrap: false,
                          childAspectRatio: 1,
                          children: [
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "1";
                                },
                                child: Text("1"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "2";
                                },
                                child: Text("2"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "3";
                                },
                                child: Text("3"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                deletechar();

                              },child: Icon(Icons.delete_outline),),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                control.clear();
                                setState(() {
                                  modetext = "";
                                });
                              },child: Icon(Icons.delete_sweep),),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "4";
                                },
                                child: Text("4"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "5";
                                },
                                child: Text("5"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "6";
                                },
                                child: Text("6"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                calculatormode = 0;
                                Firstnum = double.parse(control.text);
                                setState(() {
                                  modetext = Firstnum.toString()+"+";
                                });
                                control.clear();
                              },child: Icon(Icons.add),),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                calculatormode = 3;
                                Firstnum = double.parse(control.text);
                                setState(() {
                                  modetext = Firstnum.toString()+"-";
                                });
                                control.clear();
                              },child: Text("-"),),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "7";
                                },
                                child: Text("7"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "8";
                                },
                                child: Text("8"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "9";
                                },
                                child: Text("9"),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                calculatormode = 1;
                                Firstnum = double.parse(control.text);
                                setState(() {
                                  modetext = Firstnum.toString()+"*";
                                });
                                control.clear();
                              },child: Text("*"),),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                calculatormode = 2;
                                Firstnum = double.parse(control.text);
                                setState(() {
                                  modetext = Firstnum.toString()+"/";
                                });
                                control.clear();
                              },child: Text("/"),),
                            ),

                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + ".";
                                },
                                child: Text("."),
                              ),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  control.text = control.text + "0";
                                },
                                child: Text("0"),
                              ),
                            ),

                            Container(
                              child: FloatingActionButton(onPressed: (){
                                calculatormode = 4;
                                Firstnum = double.parse(control.text);
                                setState(() {
                                  modetext = Firstnum.toString()+"*10^";
                                });
                                control.clear();
                              },child: Text("EXP"),),
                            ),
                            Container(
                              child: FloatingActionButton(onPressed: (){
                                if(c != null){
                                  control.text = c.toString();
                                }
                                else{
                                  control.text = "Do Some Calculations First.";
                                }
                              },child: Text("Ans"),),
                            ),
                            Container(
                              child: FloatingActionButton(
                                onPressed: () {
                                  equalto();
                                },
                                child: Text("="),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void deletechar() {
    if (!control.text.isEmpty) {
      control.text = control.text.substring(0, control.text.length - 1);
    }
  }


  void equalto() {
    double b = double.parse(control.text);
    switch(calculatormode){
      case 0:
        c = Firstnum + b;
        control.text = c.toString();

        break;
      case 1:
        c = Firstnum * b;
        control.text = c.toString();
        break;
      case 2:
        c = Firstnum / b;
        control.text = c.toString();
        break;
      case 3:
        c = Firstnum - b;
        control.text = c.toString();
        break;
      case 4:
        c = pow(Firstnum, b);
        control.text = c.toString();
        break;
    }
  }
}
