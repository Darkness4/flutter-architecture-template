import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/usecases/get_github_releases.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/bloc.dart';

class GithubReleasesBloc
    extends Bloc<GithubReleasesEvent, GithubReleasesState> {
  final GetGithubReleases getGithubReleases;

  GithubReleasesBloc({
    @required this.getGithubReleases,
  }) : assert(getGithubReleases != null);

  @override
  GithubReleasesState get initialState => const GithubReleasesStateInitial();

  @override
  Stream<GithubReleasesState> mapEventToState(
    GithubReleasesEvent event,
  ) async* {
    if (event is GetReleasesEvent) {
      yield const GithubReleasesStateLoading();
      try {
        final releases = await getGithubReleases(event.repo);
        yield GithubReleasesStateLoaded(releases: releases);
      } catch (e) {
        yield GithubReleasesStateError(message: e.toString());
      }
    }
  }
}
