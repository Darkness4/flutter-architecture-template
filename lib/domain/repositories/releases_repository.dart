import 'package:flutter_architecture_template/domain/entities/github/release.dart';

abstract class ReleasesRepository {
  Future<List<GithubRelease>> getReleases(String repo);
}
