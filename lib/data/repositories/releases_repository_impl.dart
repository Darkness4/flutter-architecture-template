/// Releases Repository Implementation
///
/// Après stocké les données dans un model, ce model doit être accessible peu
/// importe la source de données. C'est ce que l'on appelle un repository.
///
/// [ReleasesRepositoryImpl] est l'implémentation du [ReleasesRepository].
///
/// Le [ReleasesRepositoryImpl] possède 2 sources de données.
import 'package:connectivity/connectivity.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/repositories/releases_repository.dart';

class ReleasesRepositoryImpl implements ReleasesRepository {
  final GithubLocalDataSource localDataSource;
  final GithubRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  ReleasesRepositoryImpl(
      {this.localDataSource, this.remoteDataSource, this.networkInfo});

  @override
  Future<List<GithubRelease>> getReleases(String repo) {
    return _getReleases(repo);
  }

  Future<List<GithubRelease>> _getReleases(String repo) async {
    if (await networkInfo.result != ConnectivityResult.none) {
      final remoteReleases = await remoteDataSource.fetchReleases(repo);
      await localDataSource.cacheReleases(remoteReleases, repo);
      return remoteReleases;
    } else {
      return localDataSource.fetchLastReleases(repo);
    }
  }
}
