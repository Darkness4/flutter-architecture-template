import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/data/datasources/firebase_auth_data_source.dart';
import 'package:flutter_architecture_template/data/mappers/firebase_auth/app_user_mapper.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';

class AppUserRepositoryImpl implements AppUserRepository {
  final FirebaseAuthDataSource dataSource;
  final AppUserMapper userMapper;

  const AppUserRepositoryImpl({
    @required this.dataSource,
    @required this.userMapper,
  });
  @override
  Stream<AppUser> get profile => dataSource.profile.map(userMapper.mapTo);

  @override
  Future<void> setUserData(AppUser map) {
    return dataSource.setUserData(userMapper.mapFrom(map));
  }

  @override
  Future<AuthResult> signIn(String email, String password) {
    return dataSource.signIn(email, password);
  }

  @override
  Future<void> signOut() {
    return dataSource.signOut();
  }

  @override
  Future<AuthResult> signUp(String email, String password) {
    return dataSource.signUp(email, password);
  }

  @override
  Stream<FirebaseUser> get user => dataSource.user;
}
