import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/github_user/bloc.dart';

class GithubUserControls extends StatefulWidget {
  const GithubUserControls({Key key}) : super(key: key);

  @override
  _GithubUserControlsState createState() => _GithubUserControlsState();
}

class _GithubUserControlsState extends State<GithubUserControls> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          controller: controller,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'author',
          ),
          onSubmitted: (_) {
            dispatchUser();
          },
        ),
      ],
    );
  }

  void dispatchUser() {
    BlocProvider.of<GithubUserBloc>(context).add(GetUserEvent(controller.text));
  }

  @override
  void initState() {
    controller.text = 'Darkness4';
    super.initState();
  }
}
