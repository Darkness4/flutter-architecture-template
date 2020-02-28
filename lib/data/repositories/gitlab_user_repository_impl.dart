import 'package:flutter_architecture_template/data/datasources/gitlab_remote_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/gitlab_user_mapper.dart';
import 'package:flutter_architecture_template/domain/entities/gitlab_user.dart';
import 'package:flutter_architecture_template/domain/repositories/gitlab_user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@RegisterAs(GitlabUserRepository)
@lazySingleton
@injectable
class GitlabUserRepositoryImpl implements GitlabUserRepository {
  final GitlabRemoteDataSource dataSource;
  final GitlabUserMapper mapper;

  GitlabUserRepositoryImpl(this.dataSource, this.mapper);

  @override
  Future<GitlabUser> getUser(String username) {
    return dataSource.fetchUser(username).then(mapper.mapTo);
  }
}
