/// User Repository Implementation
///
/// Après stocké les données dans un model, ce model doit être accessible peu
/// importe la source de données. C'est ce que l'on appelle un repository.
///
/// [UserRepositoryImpl] est l'implémentation du [UserRepository].
///
/// Le [UserRepositoryImpl] possède 1 sources de données.
import 'package:flutter_architecture_template/data/datasources/github_remote_data_source.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final GithubRemoteDataSource remoteDataSource;

  UserRepositoryImpl({this.remoteDataSource});

  @override
  Future<GithubUser> getUser(String username) =>
      remoteDataSource.fetchUser(username);
}
