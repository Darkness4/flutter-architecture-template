import 'package:equatable/equatable.dart';

class MainPageState extends Equatable {
  final int currentIndex;

  MainPageState(this.currentIndex);

  @override
  List<Object> get props => [currentIndex];
}
