import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthSignIn
    extends Usecase<Future<AuthResult>, SignInCredentials> {
  final AppUserRepository repository;

  const FirebaseAuthSignIn(this.repository);

  @override
  Future<AuthResult> call(SignInCredentials credentials) {
    // No error handling, error will be displayed through BLoC
    return repository.signIn(credentials.email, credentials.password);
  }
}

class SignInCredentials {
  final String email;
  final String password;

  const SignInCredentials(this.email, this.password);
}
