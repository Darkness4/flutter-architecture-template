import 'package:flutter_architecture_template/core/mappers/mapper.dart';
import 'package:flutter_architecture_template/data/models/firebase_auth/app_user_model.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

class AppUserMapper implements Mapper<AppUser, AppUserModel> {
  const AppUserMapper();

  @override
  AppUserModel mapFrom(AppUser entity) {
    return AppUserModel(
      uid: entity.uid,
      email: entity.email,
      photoUrl: entity.photoUrl,
      displayName: entity.displayName,
      lastSeen: entity.lastSeen,
    );
  }

  @override
  AppUser mapTo(AppUserModel model) {
    return AppUser(
      uid: model.uid,
      email: model.email,
      photoUrl: model.photoUrl,
      displayName: model.displayName,
      lastSeen: model.lastSeen,
    );
  }
}