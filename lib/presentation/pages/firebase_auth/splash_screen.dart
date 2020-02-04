import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          child: Text("Refresh"),
          onPressed: () => context.bloc<AuthenticationBloc>().add(AppStarted()),
        ),
      ),
    );
  }
}
