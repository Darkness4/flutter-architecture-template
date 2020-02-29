import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';

abstract class AppUserRepository {
  AppUser get profile;
  Future<AuthResult> signIn(String email, String password);
  Future<AuthResult> signUp(String email, String password);
  Future<void> setUserData(AppUser map);
  Future<void> signOut();
  Future<bool> isSignedIn();
}
