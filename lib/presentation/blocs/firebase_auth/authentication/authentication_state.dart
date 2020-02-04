part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class Uninitialized extends AuthenticationState {
  const Uninitialized();
}

class Authenticated extends AuthenticationState {
  final AppUser user;

  const Authenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'Authenticated ${user.props}';
}

class Unauthenticated extends AuthenticationState {
  const Unauthenticated();
}
