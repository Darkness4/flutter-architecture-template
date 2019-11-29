import 'package:equatable/equatable.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();
}

class GoToFirstPageEvent extends MainPageEvent {
  const GoToFirstPageEvent();

  @override
  List<Object> get props => [];
}

class GoToSecondPageEvent extends MainPageEvent {
  const GoToSecondPageEvent();

  @override
  List<Object> get props => [];
}
