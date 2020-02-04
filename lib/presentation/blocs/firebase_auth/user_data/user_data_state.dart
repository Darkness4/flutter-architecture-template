part of 'user_data_bloc.dart';

abstract class UserDataState extends Equatable {
  const UserDataState();
  @override
  List<Object> get props => [];
}

class NotUpdatedState extends UserDataState {
  const NotUpdatedState();
}

class LoadingState extends UserDataState {
  const LoadingState();
}

class UpdatedState extends UserDataState {
  const UpdatedState();
}

class ErrorState extends UserDataState {
  const ErrorState();
}
