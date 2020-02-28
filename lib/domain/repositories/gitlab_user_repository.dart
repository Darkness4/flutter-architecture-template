import 'package:flutter_architecture_template/domain/entities/gitlab_user.dart';

abstract class GitlabUserRepository {
  Future<GitlabUser> getUser(String username);
}
