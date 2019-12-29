import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/data/models/firebase_auth/app_user_model.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/repositories/firebase_auth/app_user_repository.dart';

class AppUserRepositoryImpl implements AppUserRepository {
  @override
  // TODO: implement profile
  Stream<AppUser> get profile => throw UnimplementedError();

  @override
  Future<void> setUserData(AppUserModel map) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<void> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<void> signOut() {
    // TODO: implement signOut
    throw UnimplementedError();
  }

  @override
  Future<void> signUp(String email, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Stream<FirebaseUser> get user => throw UnimplementedError();
}
