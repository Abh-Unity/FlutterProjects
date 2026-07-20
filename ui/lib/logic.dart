import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui/httpcubit.dart';

class logic extends StatefulWidget {
  const logic({super.key});

  @override
  State<logic> createState() => _logicState();
}

String message = "No data";

class _logicState extends State<logic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Weather"),
        backgroundColor: Color(0xFF17152D),
        foregroundColor: Colors.white,
        shape: Border(bottom: BorderSide(color: Colors.black)),
      ),
      body: BlocBuilder<textcubit, Textstate>(
        builder: (context, state) => Expanded(
          child: Container(
            width: 402,
            height: 874,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0.50, -0.00),
                end: Alignment(0.50, 1.00),
                colors: [const Color(0xFF17152D), const Color(0xFF532BDC)],
              ),
            ),
            child: Stack(
              children: [
                Positioned(
                  left: 125,
                  top: 65,
                  child: Text(
                    'Weather\nof',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 98,
                  top: 202,
                  child: Container(
                    width: 198,
                    height: 198,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/images/images (1).png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 449,
                  child: Text(
                    'LATITUDE:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 125,
                  top: 449,
                  child: state.weathercondition == null || state.temp == null
                      ? Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          state.weathercondition!["latitude"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
                Positioned(
                  left: 6,
                  top: 504,
                  child: Text(
                    'LONGITUDE:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 137,
                  top: 504,
                  child: state.weathercondition == null || state.temp == null
                      ? Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        )
                      : Text(
                          state.weathercondition!["longitude"].toString(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                ),
                Positioned(
                  left: 6,
                  top: 559,
                  child: SizedBox(
                    width: 114,
                    height: 23,
                    child: Text(
                      'ELEVATION:',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 130,
                  top: 559,
                  child: SizedBox(
                    width: 134,
                    height: 23,
                    child: state.weathercondition == null || state.temp == null
                        ? Text(
                            message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            state.weathercondition!["elevation"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  left: 268,
                  top: 613,
                  child: SizedBox(
                    width: 134,
                    height: 25,
                    child: state.weathercondition == null || state.temp == null
                        ? Text(
                            message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            state.temp!["current"]["temperature_2m"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  left: 211,
                  top: 669,
                  child: SizedBox(
                    width: 134,
                    height: 25,
                    child: state.weathercondition == null || state.temp == null
                        ? Text(
                            message,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        : Text(
                            state.weathercondition!["current"]["us_aqi"]
                                .toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 614,
                  child: Text(
                    'CURRENT  TEMPERATURE:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Positioned(
                  left: 6,
                  top: 669,
                  child: Text(
                    'AIR QUALITY INDEX:',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: 'Inter',
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<textcubit>().settext(),
        child: Icon(Icons.download),
      ),
    );
  }
}
