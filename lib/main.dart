import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart' as di;
import 'package:flutter_architecture_template/presentation/pages/github_releases_page.dart';
import 'package:flutter_architecture_template/presentation/router.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: di.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return Container();
          case ConnectionState.done:
            return MaterialApp(
              title: 'Github Releases Watcher',
              home: GithubReleasesPage(),
              onGenerateRoute: Router.generateRoute,
            );
        }
        return null;
      },
    );
  }
}
