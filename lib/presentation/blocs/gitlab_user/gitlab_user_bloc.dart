import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architecture_template/domain/entities/gitlab_user.dart';
import 'package:flutter_architecture_template/domain/usecases/get_gitlab_user.dart';
import 'package:injectable/injectable.dart';

part 'gitlab_user_event.dart';
part 'gitlab_user_state.dart';

@prod
@injectable
class GitlabUserBloc extends Bloc<GitlabUserEvent, GitlabUserState> {
  final GetGitlabUser getGitlabUser;

  GitlabUserBloc({
    @required this.getGitlabUser,
  }) : assert(getGitlabUser != null);

  @override
  GitlabUserState get initialState => GitlabUserStateInitial();

  @override
  Stream<GitlabUserState> mapEventToState(
    GitlabUserEvent event,
  ) async* {
    if (event is GitlabUserGet) {
      yield GitlabUserStateLoading();
      try {
        final user = await getGitlabUser(event.username);
        yield GitlabUserStateLoaded(user);
      } catch (e) {
        yield GitlabUserStateError(e);
      }
    }
  }
}
