import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/pages/firebase_auth/forgot_screen.dart';

class ForgotPasswordButton extends StatelessWidget {
  ForgotPasswordButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      child: Text(
        'Forgot Password',
      ),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) {
            return ForgotScreen();
          }),
        );
      },
    );
  }
}
