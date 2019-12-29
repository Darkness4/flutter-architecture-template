import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/data/models/firebase_auth/app_user_model.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

abstract class AppUserRepository {
  Stream<FirebaseUser> get user;
  Stream<AppUser> get profile;
  Future<void> signIn(String email, String password);
  Future<void> signUp(String email, String password);
  Future<void> setUserData(AppUserModel map);
  Future<void> signOut();
}
