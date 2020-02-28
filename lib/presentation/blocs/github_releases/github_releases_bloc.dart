import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_releases.dart';
import 'package:injectable/injectable.dart';

part 'github_releases_event.dart';
part 'github_releases_state.dart';

@prod
@injectable
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
