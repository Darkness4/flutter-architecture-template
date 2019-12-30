import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

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
