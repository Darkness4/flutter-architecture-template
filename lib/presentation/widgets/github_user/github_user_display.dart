import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/domain/entities/github/user.dart';

class GithubUserDisplay extends StatelessWidget {
  final GithubUser user;

  const GithubUserDisplay({
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
            Text(user.name, style: Theme.of(context).textTheme.title),
            Text(user.bio, style: Theme.of(context).textTheme.body1),
            Text(user.url, style: Theme.of(context).textTheme.body1),
          ],
        ),
      ),
    ));
  }
}
