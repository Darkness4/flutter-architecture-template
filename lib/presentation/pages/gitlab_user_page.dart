import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/blocs/gitlab_user/gitlab_user_bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/gitlab_user/gitlab_user_controls.dart';
import 'package:flutter_architecture_template/presentation/widgets/gitlab_user/gitlab_user_display.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/injection_container.dart';

class GitlabUserPage extends StatelessWidget {
  const GitlabUserPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<GitlabUserBloc> buildBody(BuildContext context) {
    return BlocProvider<GitlabUserBloc>(
      create: (_) => sl<GitlabUserBloc>(),
      child: Center(
        child: BlocBuilder<GitlabUserBloc, GitlabUserState>(
          builder: (BuildContext context, GitlabUserState state) {
            if (state is GitlabUserStateInitial) {
              return Column(
                children: <Widget>[
                  const Text('Start searching!'),
                  const GitlabUserControls(),
                ],
              );
            } else if (state is GitlabUserStateLoading) {
              return const CircularProgressIndicator();
            } else if (state is GitlabUserStateLoaded) {
              return GitlabUserDisplay(user: state.user);
            } else if (state is GitlabUserStateError) {
              return Text(state.error.toString());
            }
            return null;
          },
        ),
      ),
    );
  }
}
