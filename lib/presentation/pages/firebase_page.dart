import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/authentication_bloc.dart';
import 'package:flutter_architecture_template/presentation/pages/firebase_auth/home_screen.dart';
import 'package:flutter_architecture_template/presentation/pages/firebase_auth/login_screen.dart';
import 'package:flutter_architecture_template/presentation/pages/firebase_auth/splash_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FirebasePage extends StatelessWidget {
  const FirebasePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return buildBody(context);
  }

  BlocProvider<AuthenticationBloc> buildBody(BuildContext context) {
    return BlocProvider<AuthenticationBloc>(
      create: (_) => sl<AuthenticationBloc>()..add(AppStarted()),
      child: Center(
        child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (BuildContext context, AuthenticationState state) {
            if (state is Uninitialized) {
              return SplashScreen();
            } else if (state is Unauthenticated) {
              return LoginScreen();
            } else if (state is Authenticated) {
              return HomeScreen(user: state.user);
            }
            return null;
          },
        ),
      ),
    );
  }
}
