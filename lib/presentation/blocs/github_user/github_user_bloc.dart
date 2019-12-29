import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/usecases/github/get_user.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';

class GithubUserBloc extends Bloc<GithubUserEvent, GithubUserState> {
  final GetGithubUser getGithubUser;

  GithubUserBloc({
    @required this.getGithubUser,
  }) : assert(getGithubUser != null);

  @override
  GithubUserState get initialState => const GithubUserStateInitial();

  @override
  Stream<GithubUserState> mapEventToState(
    GithubUserEvent event,
  ) async* {
    if (event is GetUserEvent) {
      yield const GithubUserStateLoading();
      try {
        final user = await getGithubUser(event.username);
        yield GithubUserStateLoaded(user: user);
      } catch (e) {
        yield GithubUserStateError(message: e.toString());
      }
    }
  }
}
