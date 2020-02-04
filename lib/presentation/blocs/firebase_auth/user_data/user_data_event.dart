part of 'user_data_bloc.dart';

abstract class UserDataEvent extends Equatable {
  const UserDataEvent();

  @override
  List<Object> get props => [];
}

class UpdatedUserData extends UserDataEvent {
  final AppUser user;

  UpdatedUserData(this.user);

  @override
  List<Object> get props => [user];
}
