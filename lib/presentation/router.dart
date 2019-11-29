import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/core/routes/routes.dart';
import 'package:flutter_architecture_template/presentation/pages/main_page.dart';
import 'package:flutter_architecture_template/presentation/widgets/animations/page_transitions.dart';

class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.root:
        return FadeRoute<void>(
          builder: (BuildContext context) => MainPage(),
          settings: settings,
        );
      default:
        return MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            body: Text(
              'No route defined for ${settings.name}',
              textAlign: TextAlign.center,
            ),
          ),
        );
    }
  }
}
