import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/core/routes/routes.dart';

class FadeRoute<T> extends MaterialPageRoute<T> {
  FadeRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.name == RoutePaths.root) {
      return child;
    } else {
      return FadeTransition(
        opacity: animation,
        child: child,
      );
    }
  }
}
