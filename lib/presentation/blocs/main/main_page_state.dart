import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();
}

class FirstPageState extends MainPageState {
  const FirstPageState();

  @override
  List<Object> get props => [];
}

class SecondPageState extends MainPageState {
  const SecondPageState();

  @override
  List<Object> get props => [];
}
