import 'dart:io';

import 'package:bloc/bloc.dart';

enum CounterEvent { increment, decremenht }

class CounterBloc extends Bloc<CounterEvent, int> {
  @override
  int get initialState {
    print('CounterBloc.initialState:+- 2');
    return 0;
  }

  @override
  Stream<int> mapEventToState(CounterEvent event) async* {
    print('CounterBloc.mapEventToState: mapEventToState: event=$event state=$state');
    //if (state == 2) {
    //  throw Exception('state is 2');
    //}
    switch (event) {
      case CounterEvent.increment:
        yield state + 1;
        break;
      case CounterEvent.decremenht:
        yield state - 1;
    }
  }

  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    //throw error;
    print('CounterBloc.onError: error=$error');
    if (stackTrace != null) {
      print(stackTrace);
    }
  }

  @override
  void onTransition(Transition<CounterEvent, int> transition) {
    print('CounterBloc.onTransition: transition=$transition');
    super.onTransition(transition);
  }
}

class MyBlocDelegate extends BlocDelegate {
  @override
  void onEvent(Bloc<dynamic, dynamic> bloc, Object event) {
    super.onEvent(bloc, event);
    print('MyBlockDelegate.onEvent: event=$event');
  }
  @override
  void onTransition(Bloc<dynamic, dynamic> bloc, Transition<dynamic, dynamic> transition) {
    super.onTransition(bloc, transition);
    print('MyBlocDelegate.onTransition: transition=$transition');
  }
}

void main(List<String> arguments) {
  print('Transitions');

  BlocSupervisor.delegate = MyBlocDelegate();
  final CounterBloc bloc = CounterBloc();

  for (int i = 0; i < 3; i++) {
    bloc.add(CounterEvent.increment);
  }
}
