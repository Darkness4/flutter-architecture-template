import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/forgot/forgot_bloc.dart';
import 'package:flutter_architecture_template/presentation/widgets/firebase_auth/forgot_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotForm extends StatefulWidget {
  State<ForgotForm> createState() => _ForgotFormState();
}

class _ForgotFormState extends State<ForgotForm> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  ForgotBloc _forgotBloc;

  bool get isPopulated => _emailController.text.isNotEmpty;

  bool isForgotButtonEnabled(ForgotState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _forgotBloc = context.bloc<ForgotBloc>();
    _emailController.addListener(_onEmailChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ForgotBloc, ForgotState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Forgoting...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          // context.bloc<AuthenticationBloc>().add(LoggedIn());
          Navigator.of(context).pop();
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Forgot Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<ForgotBloc, ForgotState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(30),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      labelText: 'Email',
                    ),
                    autocorrect: false,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  ForgotButton(
                    onPressed:
                        isForgotButtonEnabled(state) ? _onFormSubmitted : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _forgotBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onFormSubmitted() {
    _forgotBloc.add(
      Submitted(
        email: _emailController.text,
      ),
    );
  }
}
