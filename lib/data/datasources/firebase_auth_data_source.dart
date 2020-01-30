import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/data/models/firebase_auth/app_user_model.dart';
import 'package:rxdart/rxdart.dart' show SwitchMapExtension;

abstract class FirebaseAuthDataSource {
  Stream<FirebaseUser> get user;
  Stream<AppUserModel> get profile;

  Future<AuthResult> signIn(String email, String password);
  Future<AuthResult> signUp(String email, String password);

  Future<void> setUserData(AppUserModel map);

  Future<void> signOut();
}

class FirebaseAuthDataSourceImpl implements FirebaseAuthDataSource {
  final FirebaseAuth auth;
  final Firestore db;

  const FirebaseAuthDataSourceImpl({
    @required this.auth,
    @required this.db,
  });

  @override
  Stream<FirebaseUser> get user => auth.onAuthStateChanged;

  @override
  Stream<AppUserModel> get profile => user.switchMap((FirebaseUser user) {
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
  Future<AuthResult> signUp(String email, String password) =>
      auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
}
