part of 'main_page_bloc.dart';

abstract class MainPageEvent extends Equatable {
  const MainPageEvent();

  @override
  List<Object> get props => [];
}

class GoToPageEvent extends MainPageEvent {
  final int index;

  const GoToPageEvent(this.index);

  @override
  List<Object> get props => [index];
}
