import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/bloc.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/widgets/bottom_navigation_bar.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_releases/github_releases_controls.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_releases/github_releases_display.dart';

const int CURRENT_PAGE = 0;

class GithubReleasesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Github Releases'),
      ),
      body: buildBody(context),
      bottomNavigationBar:
          MainBottomNavigationBar.generate(context, CURRENT_PAGE),
    );
  }

  BlocProvider<GithubReleasesBloc> buildBody(BuildContext context) {
    return BlocProvider(
      builder: (_) => sl<GithubReleasesBloc>(),
      child: Container(
        alignment: Alignment.center,
        color: Colors.yellow,
        child: BlocBuilder<GithubReleasesBloc, GithubReleasesState>(
          builder: (BuildContext context, GithubReleasesState state) {
            if (state is GithubReleasesStateInitial) {
              return Column(
                children: <Widget>[
                  const Text('Start searching!'),
                  const GithubReleasesControls(),
                ],
              );
            } else if (state is GithubReleasesStateLoading) {
              return const CircularProgressIndicator();
            } else if (state is GithubReleasesStateLoaded) {
              return GithubReleasesDisplay(releases: state.releases);
            } else if (state is GithubReleasesStateError) {
              return Text(state.message);
            }
            return null;
          },
        ),
      ),
    );
  }
}
