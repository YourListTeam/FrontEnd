import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/screens/authenticate/authGeneral.dart';
import 'package:your_list_flutter_app/screens/authenticate/login_bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/services/auth.dart';

class Authenticate extends StatelessWidget {
  final AuthService _authService;
  Authenticate({Key key, @required AuthService authService})
    : assert(authService != null),
      _authService = authService,
      super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: BlocProvider<LoginBloc>(
          create: (context) => LoginBloc(authService: _authService),
          child: GeneralAuth(authService: _authService),
        ),
      ),
    );
  }
}