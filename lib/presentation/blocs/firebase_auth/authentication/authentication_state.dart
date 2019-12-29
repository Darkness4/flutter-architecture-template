import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {}

class Authenticated extends AuthenticationState {
  final AppUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated ${user.props}';
}

class Unauthenticated extends AuthenticationState {}
