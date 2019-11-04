import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/repositories/user_repository.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';

class GithubUserBloc extends Bloc<GithubUserEvent, GithubUserState> {
  final UserRepository repository;

  GithubUserBloc({
    @required this.repository,
  }) : assert(repository != null);

  @override
  GithubUserState get initialState => const GithubUserStateInitial();

  @override
  Stream<GithubUserState> mapEventToState(
    GithubUserEvent event,
  ) async* {
    if (event is GetUserEvent) {
      yield const GithubUserStateLoading();
      try {
        final user = await repository.getUser(event.username);
        yield GithubUserStateLoaded(user: user);
      } catch (e) {
        yield GithubUserStateError(message: e.toString());
      }
    }
  }
}
