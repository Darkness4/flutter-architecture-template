import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/login/login_bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/firebase_auth/login_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (context) => sl<LoginBloc>(),
      child: LoginForm(),
    );
  }
}
