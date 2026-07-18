import 'dart:ffi';

import 'package:bloclearn/textcubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class famui extends StatefulWidget {
  const famui({super.key});

  @override
  State<famui> createState() => _famuiState();
}

class _famuiState extends State<famui> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<Textcubit, Textstate>(
        builder: (context, state) => Center(
          child: state.data != null
              ? Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(
                    children: [
                      Text(state.data!["id"].toString()),
                      Text(state.data!["name"]),
                      Text(state.data!["username"]),
                    ],
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(100.0),
                  child: Column(
                    children: [
                      Text(
                        state.message ??
                            "Click the button below to load the json data",
                      ),
                    ],
                  ),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<Textcubit>().settext(),
        child: Text("Load"),
      ),
    );
  }
}
