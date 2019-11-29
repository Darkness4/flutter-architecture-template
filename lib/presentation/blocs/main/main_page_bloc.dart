import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  int currentIndex = 0;

  @override
  MainPageState get initialState => const FirstPageState();

  @override
  Stream<MainPageState> mapEventToState(
    MainPageEvent event,
  ) async* {
    if (event is GoToFirstPageEvent) {
      currentIndex = 0;
      yield const FirstPageState();
    } else if (event is GoToSecondPageEvent) {
      currentIndex = 1;
      yield const SecondPageState();
    }
  }
}
