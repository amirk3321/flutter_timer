import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import '../model/ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  static int _duration=60;
  final Ticker _ticker;



  TimerBloc({Ticker ticker})
      :assert(ticker!=null),
  _ticker=ticker;

  StreamSubscription<int> _tickerSubscription;

  @override
  TimerState get initialState => ReadyState(duration: _duration);

  @override
  void dispose() {
    _tickerSubscription?.cancel();
    super.dispose();
  }
  @override
  Stream<TimerState> mapEventToState(
    TimerEvent event,
  ) async* {
    if (event is StartEvent){
      yield* _mapStartEventToState(event);
    }else if (event is PauseEvent){
      yield* _mapPauseEventToState(event);
    }else if (event is ResumeEvent){
      yield* _mapResumeEventToState(event);
    }else if (event is ResetEvent){
      yield* _mapResetEventToState(event);
    }else if(event is Tick) {
      yield* _mapTickToState(event);
    }else if (event is UpdateTimeEvent){
      yield*  _mapUpdateTimeToState(event);
    }
  }

  Stream<TimerState> _mapStartEventToState(StartEvent start) async*{
      yield RunningState(duration: start.duration);
      _tickerSubscription?.cancel();
      _tickerSubscription=_ticker.tick(ticks:start.duration)
          .listen((duration){
         dispatch(Tick(duration: duration));
      });
  }


  Stream<TimerState> _mapTickToState(Tick tick) async*{
    yield tick.duration > 0 ? RunningState(duration: tick.duration) :FinishedState();
  }

  Stream<TimerState> _mapPauseEventToState(PauseEvent pause) async*{
    final state =currentState;
    if (state is RunningState){
      _tickerSubscription?.pause();
      yield PausedState(duration: state.duration);
    }
  }

  Stream<TimerState> _mapResumeEventToState(ResumeEvent event) async*{
    final state=currentState;

    if (state is PausedState){
      _tickerSubscription?.resume();
      yield RunningState(duration: state.duration);
    }
  }

  Stream<TimerState> _mapResetEventToState(ResetEvent reset) async*{
    _tickerSubscription?.cancel();
    yield ReadyState(duration:_duration);
  }



  Stream<TimerState> _mapUpdateTimeToState(UpdateTimeEvent updateTimeEvent) async*{

    _tickerSubscription?.cancel();
    _tickerSubscription=_ticker.tick(ticks:updateTimeEvent.duration)
        .listen((duration){
      dispatch(Tick(duration: duration));
      _duration=updateTimeEvent.duration;
    });

  }
}


