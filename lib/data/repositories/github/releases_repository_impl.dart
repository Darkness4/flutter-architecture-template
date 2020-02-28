/// Releases Repository Implementation
///
/// Après stocké les données dans un model, ce model doit être accessible peu
/// importe la source de données. C'est ce que l'on appelle un repository.
///
/// [ReleasesRepositoryImpl] est l'implémentation du [ReleasesRepository].
///
/// Le [ReleasesRepositoryImpl] possède 2 sources de données.
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/github/release_mapper.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/repositories/github/releases_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@RegisterAs(ReleasesRepository)
@lazySingleton
@injectable
class ReleasesRepositoryImpl implements ReleasesRepository {
  final GithubLocalDataSource localDataSource;
  final GithubRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final GithubReleaseMapper releaseMapper;

  const ReleasesRepositoryImpl({
    @required this.localDataSource,
    @required this.remoteDataSource,
    @required this.networkInfo,
    @required this.releaseMapper,
  });

  @override
  Future<List<GithubRelease>> getReleases(String repo) {
    return _getReleases(repo);
  }

  Future<List<GithubRelease>> _getReleases(String repo) async {
    if (await networkInfo.result != ConnectivityResult.none) {
      final remoteReleases = await remoteDataSource.fetchReleases(repo);
      await localDataSource.cacheReleases(remoteReleases, repo);
      return remoteReleases.map(releaseMapper.mapTo).toList();
    } else {
      final localReleases = await localDataSource.fetchLastReleases(repo);
      return localReleases.map(releaseMapper.mapTo).toList();
    }
  }
}
