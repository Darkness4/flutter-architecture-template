import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final String name;

  HomeScreen({Key key, @required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(child: Text('Welcome $name!')),
        RaisedButton(
          child: Text("SignOut"),
          onPressed: () {
            BlocProvider.of<AuthenticationBloc>(context).add(
              LoggedOut(),
            );
          },
        )
      ],
    );
  }
}
