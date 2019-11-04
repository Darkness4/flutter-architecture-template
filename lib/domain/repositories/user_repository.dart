import 'package:flutter_architecture_template/domain/entities/github/user.dart';

abstract class UserRepository {
  Future<GithubUser> getUser(String username);
}
