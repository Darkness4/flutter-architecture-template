import 'package:flutter/material.dart';
import 'package:flutter_architecture_template/domain/entities/firebase_auth/app_user.dart';
import 'package:flutter_architecture_template/injection_container.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/authentication/authentication_bloc.dart';
import 'package:flutter_architecture_template/presentation/blocs/firebase_auth/user_data/user_data_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  final AppUser user;

  HomeScreen({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Center(child: Text('Welcome ${user.email}!')),
        BlocProvider<UserDataBloc>(
          create: (_) => sl<UserDataBloc>(),
          child: BlocBuilder<UserDataBloc, UserDataState>(
            builder: (BuildContext context, UserDataState state) {
              if (state is UpdatedState || state is NotUpdatedState)
                return Switch(
                  value: user.isAdmin,
                  onChanged: (value) {
                    final AppUser newUser = AppUser.setAdmin(user, value);
                    sl<UserDataBloc>().add(UpdatedUserData(newUser));
                  },
                );
              else
                return const CircularProgressIndicator();
            },
          ),
        ),
        RaisedButton(
          child: Text("SignOut"),
          onPressed: () {
            context.bloc<AuthenticationBloc>().add(LoggedOut());
          },
        ),
      ],
    );
  }
}
