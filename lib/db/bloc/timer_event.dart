import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class TimerEvent extends Equatable {
  TimerEvent([List props = const []]) : super(props);
}

class StartEvent extends TimerEvent{
  final int duration;
  StartEvent({this.duration}) : super([duration]);

  @override
  String toString() => "StartEvent duration $duration";
}

class PauseEvent extends TimerEvent{
  @override
  String toString() => "PauseEvent duration";
}


class ResumeEvent extends TimerEvent{

  @override
  String toString() => "ResumeEvent";
}

class ResetEvent extends TimerEvent{

  @override
  String toString() => "ResetEvent";
}

//Informs the TimerBloc that a tick has occurred and
// that it needs to update its state accordingly.
class Tick extends TimerEvent{
  final int duration;

  Tick({this.duration}) : super([duration]);

  @override
  String toString() => "Tick - duration :$duration";
}



