import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/forgot/forgot_bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/firebase_auth/forgot_form.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotScreen extends StatelessWidget {
  ForgotScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Forgot Password')),
      body: Center(
        child: BlocProvider<ForgotBloc>(
          create: (_) => sl<ForgotBloc>(),
          child: ForgotForm(),
        ),
      ),
    );
  }
}
