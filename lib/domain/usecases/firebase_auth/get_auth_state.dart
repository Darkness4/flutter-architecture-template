import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';

class GetAuthState extends UsecaseStream<FirebaseUser, NoParams> {
  final AppUserRepository repository;

  const GetAuthState(this.repository);

  @override
  Stream<FirebaseUser> call(NoParams) {
    return repository.user.asBroadcastStream();
  }
}
