import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/core/routes/routes.dart';
import 'package:flutter_architecture_template/injection_container.dart' as di;
import 'package:flutter_architecture_template/presentation/router.dart';
import 'package:hive/hive.dart';

Future<void> main() async {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: di.init(),
      builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
        if (snapshot.hasError) {
          return MaterialApp(
              home: Center(child: Text(snapshot.error.toString())));
        }
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
          case ConnectionState.active:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case ConnectionState.done:
            return const MaterialApp(
              title: 'Github Releases Watcher',
              initialRoute: RoutePaths.root,
              onGenerateRoute: Router.generateRoute,
            );
        }
        return null;
      },
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
