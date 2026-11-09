import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:gps_clean_architecture/data/dataRepository.dart';
import 'package:gps_clean_architecture/data/deviceinfo.dart';
import 'package:gps_clean_architecture/data/hold_data.dart';
import 'package:gps_clean_architecture/data/retrieveddataclass.dart';

abstract class statemanager extends Equatable {}

abstract class eventmanager {}

class initialstate extends statemanager {
  final String message;

  initialstate({required this.message});

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

abstract class historystate {}

abstract class historyevent {}

class location extends Bloc<historyevent, historystate> {
  final Userrepository userrepo;

  location({required this.userrepo})
    : super(
        initialscreen(
          initialmessage: "press the button to fetch the location history.",
        ),
      ) {
    on<locationrecord>((event, emit) async {
      List<retrieved_data>? data = await userrepo.getdatafromserver();
      if (data != null) {
        print("the data is there.");
        emit(displayrecord(data: data));
      } else {
        print("absence of data.");
        emit(emptydata(emptymessage: "empty record."));
      }
    });
  }
}

class emptydata extends historystate {
  final emptymessage;

  emptydata({required this.emptymessage});
}

class catchedmessage extends historystate {
  final errmessage;

  catchedmessage({required this.errmessage});
}

class locationrecord extends historyevent {}

class displayrecord extends historystate {
  final List<retrieved_data?> data;

  displayrecord({required this.data});
}

class initialscreen extends historystate {
  final String initialmessage;

  initialscreen({required this.initialmessage});
}

class handlegps extends Bloc<eventmanager, statemanager> {
  final Userrepository datarepo;
  final deviceid androidid;
  StreamSubscription<Position>? pos;

  handlegps({required this.datarepo, required this.androidid})
    : super(initialstate(message: "please tap on start to turn the gps on")) {
    on<handle>((event, emit) async {
      try {
        pos = datarepo.geo.getcontinuousLocation.listen((Position value) async {
          var deviceiddata = await androidid.resolvedeviceinfo();
          add(start(Value: value, devid: deviceiddata!, time: DateTime.now()));
        });
      } catch (e) {
        emit(
          nokey(
            errormessage:
                "please check if the location services are turned on then press start",
          ),
        );
      }
    });
    on<start>((event, emit) async {
      hold_data data = datarepo.get_data(event.Value, event.devid, event.time);
      await datarepo.registerdataontobox(data);
      print("the devid from statemanagement is:${event.devid}");
      print("emitting the coordinates");
      emit(dataholder(data: data));
    });
    on<stop>((event, emit) {
      pos?.cancel();
      emit(stopmessage(stopmsg: "press the button to start the gps tracking."));
    });
  }
}

class stopmessage extends statemanager {
  final stopmsg;

  stopmessage({required this.stopmsg});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class stop extends eventmanager {}

class buttontext extends statemanager {
  final btntext;

  buttontext({required this.btntext});

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class start extends eventmanager {
  final Value;
  final String devid;
  final DateTime time;

  start({required this.Value, required this.devid, required this.time});
}

class handle extends eventmanager {}

class locationrequired extends statemanager {
  final requiredmessage;

  //always allow is required for the app to function as intended.
  locationrequired({required this.requiredmessage});

  @override
  // TODO: implement props
  List<Object?> get props => [requiredmessage];
}

class nokey extends statemanager {
  final errormessage;

  nokey({required this.errormessage});

  @override
  // TODO: implement props
  List<Object?> get props => [errormessage];
}

class dataholder extends statemanager {
  final hold_data data;

  dataholder({required this.data});

  @override
  // TODO: implement props
  List<Object?> get props => [data];
}
