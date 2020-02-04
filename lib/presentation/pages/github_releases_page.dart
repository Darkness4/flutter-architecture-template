import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/github_releases_bloc.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_releases/github_releases_controls.dart';
import 'package:flutter_architecture_template/presentation/widgets/github_releases/github_releases_display.dart';

class GithubReleasesPage extends StatelessWidget {
  const GithubReleasesPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<GithubReleasesBloc> buildBody(BuildContext context) {
    return BlocProvider<GithubReleasesBloc>(
      create: (_) => sl<GithubReleasesBloc>(),
      child: Center(
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
