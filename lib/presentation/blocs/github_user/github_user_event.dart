part of 'github_user_bloc.dart';

class GetUserEvent extends GithubUserEvent {
  final String username;

  const GetUserEvent(this.username);

  @override
  List<Object> get props => [username];
}

@immutable
abstract class GithubUserEvent extends Equatable {
  const GithubUserEvent();
}
