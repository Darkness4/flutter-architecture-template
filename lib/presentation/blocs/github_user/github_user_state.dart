import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

@immutable
abstract class GithubUserState extends Equatable {
  @override
  List<Object> get props => [];
}

class GithubUserStateError extends GithubUserState {
  final String message;

  GithubUserStateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GithubUserStateInitial extends GithubUserState {}

class GithubUserStateLoaded extends GithubUserState {
  final GithubUser user;

  GithubUserStateLoaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class GithubUserStateLoading extends GithubUserState {}
