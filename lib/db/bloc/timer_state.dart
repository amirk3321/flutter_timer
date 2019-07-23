import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerState extends Equatable {
  final int duration;
  TimerState(this.duration,[List props = const []]) : super([duration]..add(props));
}

class ReadyState extends TimerState{
  ReadyState({int duration}) :super(duration);

  @override
  String toString() => "ReadyState duration $duration";
}

class PausedState extends TimerState{
  PausedState({int duration}) :super(duration);

  @override
  String toString() => "PausedState duration $duration";
}

class RunningState extends TimerState{

  RunningState({int duration}) : super(duration);

  @override
  String toString() => "RunningState duration $duration";
}

class FinishedState extends TimerState{

  FinishedState() : super(0);

  @override
  String toString() => "FinishedState duration $duration";
}