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
/// [GetGithubReleases] doit remplir le use case suivant:
///
/// - Obtenir les releases d'un dépôt particulier.
import 'package:equatable/equatable.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/github/release.dart';
import 'package:flutter_architecture_template/domain/repositories/releases_repository.dart';

class GetGithubReleases extends Usecase<List<GithubRelease>, Params> {
  final ReleasesRepository repository;

  const GetGithubReleases(this.repository);

  @override
  Future<List<GithubRelease>> call(Params params) async {
    // No error handling, error will be displayed through BLoC
    return repository.getReleases(params.repo);
  }
}

class Params extends Equatable {
  final String repo;

  const Params(this.repo);

  @override
  List<Object> get props => [repo];
}
