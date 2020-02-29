import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/data/models/firebase_auth/app_user_model.dart';
import 'package:injectable/injectable.dart';
import 'package:rxdart/rxdart.dart' show BehaviorSubject, SwitchMapExtension;

abstract class FirebaseAuthDataSource {
  AppUserModel get profile;

  Future<AuthResult> signIn(String email, String password);
  Future<AuthResult> signUp(String email, String password);

  Future<void> setUserData(AppUserModel map);
  Future<bool> isSignedIn();

  Future<void> forgotPassword(String email);

  Future<void> signOut();
}

@RegisterAs(FirebaseAuthDataSource)
@prod
@lazySingleton
@injectable
class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth auth;
  final Firestore db;
  final BehaviorSubject<AppUserModel> profileController =
      BehaviorSubject<AppUserModel>();

  FirebaseAuthDataSourceImpl({
    @required this.auth,
    @required this.db,
  }) {
    Stream<AppUserModel> stream =
        auth.onAuthStateChanged.switchMap((FirebaseUser user) {
      if (user != null) {
        return db
            .collection('users')
            .document(user.uid)
            .snapshots()
            .map((snap) => AppUserModel.fromMap(snap.data));
      } else {
        return Stream<AppUserModel>.value(AppUserModel());
      }
    });
    stream.listen(profileController.add);
  }

  @override
  AppUserModel get profile => profileController.value;

  Future<bool> isSignedIn() async {
    final currentUser = await auth.currentUser();
    return currentUser != null;
  }

  @override
  Future<AuthResult> signIn(String email, String password) async {
    final AuthResult result = await auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    await _updateUserData(result.user);
    return result;
  }

  Future<void> _updateUserData(FirebaseUser user) async {
    final DocumentReference ref = db.collection('users').document(user.uid);

    return ref.setData({
      'uid': user.uid,
      'email': user.email,
      'photoUrl': user.photoUrl,
      'displayName': user.displayName,
      'lastSeen': DateTime.now(),
    }, merge: true);
  }

  @override
  Future<void> setUserData(AppUserModel appUser) {
    final DocumentReference ref = db.collection('users').document(appUser.uid);

    return ref.setData(appUser.toMap(), merge: true);
  }

  @override
  Future<void> signOut() => auth.signOut();

  @override
  Future<void> forgotPassword(String email) =>
      auth.sendPasswordResetEmail(email: email);

  @override
  Future<AuthResult> signUp(String email, String password) =>
      auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
}
