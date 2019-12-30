import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_auth_state.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signout.dart';
import 'package:rxdart/rxdart.dart' show SwitchMapExtension;

import 'bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final FirebaseAuthSignOut firebaseAuthSignOut;
  final GetAuthState getAuthState;
  final GetAppUser getAppUser;

  AuthenticationBloc({
    @required this.firebaseAuthSignOut,
    @required this.getAuthState,
    @required this.getAppUser,
  });

  @override
  AuthenticationState get initialState => Uninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
    AuthenticationEvent event,
  ) async* {
    if (event is AppStarted) {
      yield* _mapAppStartedToState();
    } else if (event is LoggedIn) {
      yield* _mapLoggedInToState();
    } else if (event is LoggedOut) {
      yield* _mapLoggedOutToState();
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState() async* {
    yield Unauthenticated();
    yield* getAuthState(NoParams()).switchMap((FirebaseUser user) {
      if (user == null) {
        return Stream.value(Unauthenticated());
      } else {
        return getAppUser(NoParams())
            .map((AppUser user) => Authenticated(user));
      }
    });
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield* getAppUser(NoParams()).map((AppUser user) => Authenticated(user));
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    await firebaseAuthSignOut(NoParams());
  }
}
