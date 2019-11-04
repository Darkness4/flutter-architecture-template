import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

@immutable
abstract class GithubUserState extends Equatable {
  const GithubUserState();
}

class GithubUserStateError extends GithubUserState {
  final String message;

  const GithubUserStateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GithubUserStateInitial extends GithubUserState {
  const GithubUserStateInitial();
  @override
  List<Object> get props => [];
}

class GithubUserStateLoaded extends GithubUserState {
  final GithubUser user;

  const GithubUserStateLoaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class GithubUserStateLoading extends GithubUserState {
  const GithubUserStateLoading();
  @override
  List<Object> get props => [];
}
