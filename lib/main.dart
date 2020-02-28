import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/core/routes/routes.dart';
import 'package:flutter_architecture_template/injection_container.dart' as di;
import 'package:flutter_architecture_template/presentation/router.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox<String>('prefs');
  await di.init(env: Environment.prod);
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Github Releases Watcher',
      initialRoute: RoutePaths.root,
      onGenerateRoute: Router.generateRoute,
    );
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
