import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_user/github_user_controls.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_user/github_user_display.dart';

const int CURRENT_PAGE = 1;

class GithubUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github User'),
      ),
      body: buildBody(context),
      bottomNavigationBar:
          MainBottomNavigationBar.generate(context, CURRENT_PAGE),
    );
  }

  BlocProvider<GithubUserBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<GithubUserBloc>(),
      child: Container(
        alignment: Alignment.center,
        color: Colors.blue,
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
