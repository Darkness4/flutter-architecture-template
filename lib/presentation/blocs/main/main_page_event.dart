import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class GoToFirstPageEvent extends MainPageEvent {
  const GoToFirstPageEvent();
}

class GoToSecondPageEvent extends MainPageEvent {
  const GoToSecondPageEvent();
}

class GoToThirdPageEvent extends MainPageEvent {
  const GoToThirdPageEvent();
}
