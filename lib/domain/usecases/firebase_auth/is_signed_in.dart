import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class IsSignedIn extends Usecase<Future<bool>, NoParams> {
  final AppUserRepository repository;

  const IsSignedIn(this.repository);

  @override
  Future<bool> call(NoParams) {
    return repository.isSignedIn();
  }
}
