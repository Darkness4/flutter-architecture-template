import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/github_user_bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_user/github_user_controls.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_user/github_user_display.dart';

class GithubUserPage extends StatelessWidget {
  const GithubUserPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<GithubUserBloc> buildBody(BuildContext context) {
    return BlocProvider<GithubUserBloc>(
      create: (_) => sl<GithubUserBloc>(),
      child: Center(
        child: BlocBuilder<GithubUserBloc, GithubUserState>(
          builder: (BuildContext context, GithubUserState state) {
            if (state is GithubUserStateInitial) {
              return Column(
                children: <Widget>[
                  const Text('Start searching!'),
                  const GithubUserControls(),
                ],
              );
            } else if (state is GithubUserStateLoading) {
              return const CircularProgressIndicator();
            } else if (state is GithubUserStateLoaded) {
              return GithubUserDisplay(user: state.user);
            } else if (state is GithubUserStateError) {
              return Text(state.message);
            }
            return null;
          },
        ),
      ),
    );
  }
}
