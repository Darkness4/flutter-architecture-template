import 'package:equatable/equatable.dart';

abstract class MainPageState extends Equatable {
  const MainPageState();

  @override
  List<Object> get props => [];
}

class FirstPageState extends MainPageState {
  const FirstPageState();
}

class SecondPageState extends MainPageState {
  const SecondPageState();
}
