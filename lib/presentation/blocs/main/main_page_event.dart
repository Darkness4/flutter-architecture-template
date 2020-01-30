import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

@immutable
abstract class MainPageEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GoToPageEvent extends MainPageEvent {
  final int index;

  GoToPageEvent(this.index);

  @override
  List<Object> get props => [index];
}
