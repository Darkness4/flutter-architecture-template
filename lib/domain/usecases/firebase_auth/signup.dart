import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class FirebaseAuthSignUp
    extends Usecase<Future<AuthResult>, SignUpCredentials> {
  final AppUserRepository repository;

  const FirebaseAuthSignUp(this.repository);

  @override
  Future<AuthResult> call(SignUpCredentials credentials) {
    // No error handling, error will be displayed through BLoC
    return repository.signUp(credentials.email, credentials.password);
  }
}

class SignUpCredentials {
  final String email;
  final String password;

  const SignUpCredentials(this.email, this.password);
}
