part of 'github_user_bloc.dart';

@immutable
abstract class GithubUserState extends Equatable {
  const GithubUserState();

  @override
  List<Object> get props => [];
}

class GithubUserStateError extends GithubUserState {
  final String message;

  const GithubUserStateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GithubUserStateInitial extends GithubUserState {}

class GithubUserStateLoaded extends GithubUserState {
  final GithubUser user;

  const GithubUserStateLoaded({@required this.user});

  @override
  List<Object> get props => [user];
}

class GithubUserStateLoading extends GithubUserState {
  const GithubUserStateLoading();
}
