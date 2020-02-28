/// Get Github Releases
///
/// C'est ici que remplisse un usecase spécifique à l'application.
/// Par exemple, ce serait de lister des releases.
///
/// La méthode peut être rapide, comme elle peut être longue.
/// Par exemple, si le usecase est d'obtenir des releases par date de
/// publication dans l'ordre croissant, c'est ici que doit se faire le
/// "Business Logic".
///
/// C'est également ici que les erreurs sont gérées.
///
/// [GetGithubUser] doit remplir le use case suivant:
///
/// - Obtenir les releases d'un dépôt particulier.
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';
import 'package:flutter_architecture_template/domain/repositories/github/user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class GetGithubUser extends Usecase<Future<GithubUser>, String> {
  final UserRepository repository;

  const GetGithubUser(this.repository);

  @override
  Future<GithubUser> call(String user) {
    // No error handling, error will be displayed through BLoC
    return repository.getUser(user);
  }
}
