import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/core/usecases/usecase.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/get_user.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/is_signed_in.dart';
import 'package:flutter_architecture_template/domain/usecases/firebase_auth/signout.dart';
import 'package:injectable/injectable.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

@prod
@injectable
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final GetAppUser getAppUser;
  final IsSignedIn isSignedIn;
  final FirebaseAuthSignOut signOut;

  AuthenticationBloc({
    @required this.getAppUser,
    @required this.isSignedIn,
    @required this.signOut,
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
    try {
      final status = await isSignedIn(NoParams());
      if (status) {
        add(LoggedIn());
      } else {
        yield Unauthenticated();
      }
    } catch (_) {
      yield Unauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState() async* {
    yield Authenticated(getAppUser(NoParams()));
  }

  Stream<AuthenticationState> _mapLoggedOutToState() async* {
    yield Unauthenticated();
    signOut(NoParams());
  }
}
