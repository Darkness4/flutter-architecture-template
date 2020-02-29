import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';
import 'package:injectable/injectable.dart';

@prod
@lazySingleton
@injectable
class GetAppUser extends Usecase<AppUser, NoParams> {
  final AppUserRepository repository;

  const GetAppUser(this.repository);

  @override
  AppUser call(NoParams) {
    return repository.profile;
  }
}
