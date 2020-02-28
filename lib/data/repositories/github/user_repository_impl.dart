/// User Repository Implementation
///
/// Après stocké les données dans un model, ce model doit être accessible peu
/// importe la source de données. C'est ce que l'on appelle un repository.
///
/// [UserRepositoryImpl] est l'implémentation du [UserRepository].
///
/// Le [UserRepositoryImpl] possède 1 sources de données.
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/network/network_info.dart';
import 'package:flutter_architecture_template/data/datasources/github_local_data_source.dart';
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/github/user_mapper.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/domain/repositories/github/user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@RegisterAs(UserRepository)
@lazySingleton
@injectable
class UserRepositoryImpl implements UserRepository {
  final GithubLocalDataSource localDataSource;
  final GithubRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;
  final GithubUserMapper mapper;

  const UserRepositoryImpl({
    @required this.remoteDataSource,
    @required this.localDataSource,
    @required this.networkInfo,
    @required this.mapper,
  });

  @override
  Future<GithubUser> getUser(String username) => _getUser(username);

  Future<GithubUser> _getUser(String username) async {
    if (await networkInfo.result != ConnectivityResult.none) {
      final user = await remoteDataSource.fetchUser(username);
      await localDataSource.cacheUser(user, username);
      return mapper.mapTo(user);
    } else {
      final user = await localDataSource.fetchCachedUser(username);
      return mapper.mapTo(user);
    }
  }
}
