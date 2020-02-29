part of 'forgot_bloc.dart';

abstract class ForgotEvent extends Equatable {
  const ForgotEvent();

  @override
  List<Object> get props => [];
}

class EmailChanged extends ForgotEvent {
  final String email;

  const EmailChanged({@required this.email});

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'EmailChanged { email :$email }';
}

class Submitted extends ForgotEvent {
  final String email;

  const Submitted({
    @required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() {
    return 'Submitted { email: $email }';
  }
}
