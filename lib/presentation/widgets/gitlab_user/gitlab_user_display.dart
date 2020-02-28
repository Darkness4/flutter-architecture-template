import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/domain/entities/gitlab_user.dart';

class GitlabUserDisplay extends StatelessWidget {
  final GitlabUser user;

  const GitlabUserDisplay({
    Key key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
        child: SingleChildScrollView(
      child: Card(
        child: Column(
          children: <Widget>[
            Text(user.name, style: Theme.of(context).textTheme.headline6),
            Text(user.username, style: Theme.of(context).textTheme.bodyText2),
            Text(user.id.toString(),
                style: Theme.of(context).textTheme.bodyText2),
          ],
        ),
      ),
    ));
  }
}
