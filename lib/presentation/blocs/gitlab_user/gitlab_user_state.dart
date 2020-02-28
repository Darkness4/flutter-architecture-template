part of 'gitlab_user_bloc.dart';

abstract class GitlabUserState extends Equatable {
  const GitlabUserState();
}

class GitlabUserStateInitial extends GitlabUserState {
  @override
  List<Object> get props => [];
}

class GitlabUserStateLoading extends GitlabUserState {
  @override
  List<Object> get props => [];
}

class GitlabUserStateLoaded extends GitlabUserState {
  final GitlabUser user;

  const GitlabUserStateLoaded(this.user);

  @override
  List<Object> get props => [];
}

class GitlabUserStateError extends GitlabUserState {
  final dynamic error;

  const GitlabUserStateError(this.error);

  @override
  List<Object> get props => [error];
}
