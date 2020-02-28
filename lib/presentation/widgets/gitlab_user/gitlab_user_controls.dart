import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/blocs/gitlab_user/gitlab_user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GitlabUserControls extends StatefulWidget {
  const GitlabUserControls({Key key}) : super(key: key);

  @override
  _GitlabUserControlsState createState() => _GitlabUserControlsState();
}

class _GitlabUserControlsState extends State<GitlabUserControls> {
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
    context.bloc<GitlabUserBloc>().add(GitlabUserGet(controller.text));
  }

  @override
  void initState() {
    controller.text = 'Darkness4';
    super.initState();
  }
}
