
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_timer/ui/timer_screen.dart';
import 'package:overlay_support/overlay_support.dart';
import './db/bloc/bloc.dart';
import './db/bloc/delegate/simple_delegate.dart';
import './db/model/ticker.dart';
import 'package:flutter/material.dart';

void main() {

  BlocSupervisor.delegate=SimpleDelegate();

  runApp(myApp());
}

class myApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() =>myAppState();
}

class myAppState extends State<myApp>{
  int duration=60;
  TimerBloc _timerBloc;


  @override
  void initState() {
    _timerBloc=TimerBloc(ticker: Ticker());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OverlaySupport(
      child: MaterialApp(
        title: "Flutter Demo",
        theme: ThemeData(primarySwatch: Colors.red),
        home: BlocProvider<TimerBloc>(
          builder: (context) => _timerBloc,
          child: TimerScreen(),
        )
      ),
    );
  }
}