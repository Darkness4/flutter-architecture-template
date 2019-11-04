import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_releases/bloc.dart';

class GithubReleasesControls extends StatefulWidget {
  const GithubReleasesControls({Key key}) : super(key: key);

  @override
  _GithubReleasesControlsState createState() => _GithubReleasesControlsState();
}

class _GithubReleasesControlsState extends State<GithubReleasesControls> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'author/repo',
          ),
          onSubmitted: (_) {
            dispatchRepo();
          },
        ),
      ],
    );
  }

  void dispatchRepo() {
    BlocProvider.of<GithubReleasesBloc>(context)
        .add(GetReleasesEvent(controller.text));
  }

  @override
  void initState() {
    controller.text = 'Darkness4/minitel-app';
    super.initState();
  }
}
