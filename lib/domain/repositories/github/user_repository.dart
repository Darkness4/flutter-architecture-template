/// User Repository
///
/// Après avoir instancié un entity, cet entity doit être accessible peu
/// importe la source de données.
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

abstract class UserRepository {
  Future<GithubUser> getUser(String username);
}
