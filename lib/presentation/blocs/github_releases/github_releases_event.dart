import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

class GetReleasesEvent extends GithubReleasesEvent {
  final String repo;

  const GetReleasesEvent(this.repo);

  @override
  List<Object> get props => [repo];
}

@immutable
abstract class GithubReleasesEvent extends Equatable {
  const GithubReleasesEvent();
}
