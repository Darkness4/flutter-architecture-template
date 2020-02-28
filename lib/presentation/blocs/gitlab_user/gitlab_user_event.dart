part of 'gitlab_user_bloc.dart';

abstract class GitlabUserEvent extends Equatable {
  const GitlabUserEvent();
}

class GitlabUserGet extends GitlabUserEvent {
  final String username;

  const GitlabUserGet(this.username);

  @override
  List<Object> get props => [username];
}
