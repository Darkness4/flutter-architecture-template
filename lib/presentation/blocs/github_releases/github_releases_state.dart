part of 'github_releases_bloc.dart';

@immutable
abstract class GithubReleasesState extends Equatable {
  const GithubReleasesState();

  @override
  List<Object> get props => [];
}

class GithubReleasesStateError extends GithubReleasesState {
  final String message;

  const GithubReleasesStateError({@required this.message});

  @override
  List<Object> get props => [message];
}

class GithubReleasesStateInitial extends GithubReleasesState {
  const GithubReleasesStateInitial();
}

class GithubReleasesStateLoaded extends GithubReleasesState {
  final List<GithubRelease> releases;

  const GithubReleasesStateLoaded({@required this.releases});

  @override
  List<Object> get props => [releases];
}

class GithubReleasesStateLoading extends GithubReleasesState {
  const GithubReleasesStateLoading();
}
