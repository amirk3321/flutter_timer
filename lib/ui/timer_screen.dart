import 'package:flutter/material.dart';
import '../db/bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './action_buttons.dart';
import 'background_wave.dart';
import 'package:boxed_vertical_seekbar/boxed_vertical_seekbar.dart';


class TimerScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => TimerScreenState();

}

class TimerScreenState extends State<TimerScreen> {
  TimerBloc timerBloc;
  final _timerController =TextEditingController();
  @override
  Widget build(BuildContext context) {
    timerBloc = BlocProvider.of<TimerBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[Icon(Icons.timer), Text("\t\tTimer")],
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add_box),
            onPressed: () {
              _dialogBox(context,_timerController);
            },
          )
        ],
      ),
      body: Stack(
        children: [
          BackgroundWave(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 100.0),
                child: Center(
                  child: BlocBuilder(
                    bloc: timerBloc,
                    builder: (BuildContext context, state) {
                      final String minuteStr = ((state.duration / 60) % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      final String secondsStr = (state.duration % 60)
                          .floor()
                          .toString()
                          .padLeft(2, '0');
                      return Container(
                        child: Text(
                          '$minuteStr:$secondsStr',
                          style: TextStyle(
                              fontSize: 60, fontWeight: FontWeight.bold),
                        ),
                      );
                    },
                  ),
                ),
              ),
              BlocBuilder(
                condition: (previousState, currentState) =>
                    currentState.runtimeType != previousState.runtimeType,
                bloc: timerBloc,
                builder: (BuildContext context, state) => ActionButtons(),
              )
            ],
          ),
        ],
      ),
    );
  }
  
  _dialogBox(context,controller) async{
      await showDialog<int>(context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Set time"),
          content: Container(
            height: 150,
            width: MediaQuery.of(context).size.width/0.50,
            child: Padding(padding: EdgeInsets.all(16.0),
            child: Column(

              children: <Widget>[
                TextFormField(
                  keyboardType: TextInputType.number,
                  controller: controller,
                  decoration: InputDecoration(
                    icon: Icon(Icons.access_time),
                    hintText: "e.g 10s or 10m"
                  ),
                ),
                SizedBox(height: 5,),
                RaisedButton(
                  onPressed:  (){


                      timerBloc.dispatch(UpdateTimeEvent(duration: 60 * int.parse(_timerController.text)));

                    _timerController.text="";
                    Navigator.of(context).pop();
                  },
                  child: Text("set time"),

                )
              ],
            ),),
          ),

        );
      }
      );
  }

}
