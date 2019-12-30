import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';

class SetUserData extends UsecaseAsync<void, AppUser> {
  final AppUserRepository repository;

  const SetUserData(this.repository);

  @override
  Future<void> call(AppUser user) {
    return repository.setUserData(user);
  }
}
