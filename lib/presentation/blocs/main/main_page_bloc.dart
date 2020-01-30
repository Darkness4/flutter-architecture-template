import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  @override
  MainPageState get initialState => MainPageState(0);

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is GoToPageEvent) {
      yield MainPageState(event.index);
    }
  }
}
