
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../db/bloc/bloc.dart';


class ActionButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: _mapStateToActionButtons(bloc: BlocProvider.of<TimerBloc>(context)),
    );
  }

  List<Widget> _mapStateToActionButtons({TimerBloc bloc}) {
    final TimerState state =bloc.currentState;

    if (state is ReadyState){
     return [
     FloatingActionButton(
       child: Icon(Icons.play_arrow),
       onPressed: ()=> bloc.dispatch(StartEvent(duration: state.duration)),
     ),
     ];
    }

    if (state is RunningState){
      return [
      FloatingActionButton(
        child: Icon(Icons.pause),
        onPressed: ()=> bloc.dispatch(PauseEvent()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: ()=> bloc.dispatch(ResetEvent()),
      )
      ];
    }

    if (state is PausedState){
      return [
      FloatingActionButton(
        child: Icon(Icons.play_arrow),
        onPressed: ()=> bloc.dispatch(ResumeEvent()),
      ),
      FloatingActionButton(
        child: Icon(Icons.replay),
        onPressed: ()=> bloc.dispatch(ResetEvent()),
      ),
      ];
    }

    if (state is FinishedState){
      return [
        FloatingActionButton(
          child: Icon(Icons.replay),
          onPressed: ()=> bloc.dispatch(ResetEvent()),
        ),
      ];
    }

    return [];
  }
}