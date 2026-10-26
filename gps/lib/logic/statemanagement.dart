import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class handlegps extends Bloc<handleevent, handlestate> {
  handlegps()
    : super(
        initmessage(
          initialmessage: "press the start button to activate gps readings",
        ),
      ) {
    on<coordinates>((event, emit) {
      print("is playing");
      emit(passcoordinates(gpsposition: event.gpspos));
    });
    on<alwaysallowerror>((event, emit) {
      emit(
        allwaysallowfinal(
          finalmessage:
              "the app needs gps location set to always allow to function properly.",
        ),
      );
    });
    on<paused>((event, emit) {
      print("is paused");
      emit(pausedmessage(message: "coordinates fetching paused"));
    });
  }
}

class paused extends handleevent {}

class playafterpause {
  final Position pos;

  playafterpause({required this.pos});
}

class pausedmessage extends handlestate {
  final message;

  pausedmessage({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

class startbutton extends Bloc<buttoncontents, String> {
  startbutton() : super("start") {
    on<buttoncontents>((event, emit) {
      if (state.toString() == "stop") {
        emit("start");
      } else {
        emit("stop");
      }
    });
  }
}

class buttoncontents {}

class alwaysallowerror extends handleevent {}

class allwaysallowfinal extends handlestate {
  final finalmessage;

  allwaysallowfinal({required this.finalmessage});

  @override
  // TODO: implement props
  List<Object?> get props => [finalmessage];
}

class passcoordinates extends handlestate {
  final Position gpsposition;

  passcoordinates({required this.gpsposition});

  @override
  // TODO: implement props
  List<Object?> get props => [gpsposition];
}

class coordinates extends handleevent {
  final Position gpspos;

  coordinates({required this.gpspos});
}

class initmessage extends handlestate {
  final initialmessage;

  initmessage({required this.initialmessage});

  @override
  // TODO: implement props
  List<Object?> get props => [initialmessage];
}

abstract class handleevent {}

abstract class handlestate extends Equatable {}
