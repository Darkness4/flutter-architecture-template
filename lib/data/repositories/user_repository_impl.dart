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
