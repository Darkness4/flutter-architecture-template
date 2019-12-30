import 'package:equatable/equatable.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
  @override
  List<Object> get props => [];
}

class NotUpdatedState extends UserDataState {}

class LoadingState extends UserDataState {}

class UpdatedState extends UserDataState {}

class ErrorState extends UserDataState {}
