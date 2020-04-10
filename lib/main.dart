import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/screens/home/home.dart';
import 'package:your_list_flutter_app/screens/splash_screen.dart';
import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'models/userService.dart';
import 'package:bloc/bloc.dart';
import 'simple_bloc_delegate.dart';
import 'authentication_block/authentication_bloc.dart';
import 'screens/authenticate/authenticate.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final AuthService authService = AuthService();
  BlocSupervisor.delegate = SimpleBlocDelegate();
  runApp(BlocProvider(
    create: (context) =>
        AuthenticationBloc(authService: authService)..add(AppStarted()),
    child: MyApp(authService: authService),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthService _authService;
  String _uuid;

  FutureOr _checkResponse (Response value, UserService prov, FirebaseUser usr){
    if(!value.isSuccessful){
      var postUsr = new Map<dynamic, dynamic>();
      print("posting");
      postUsr["UUID"] = usr.uid;
      postUsr["email"] = usr.email;
      postUsr["name"] = usr.displayName;
      prov.postUser(postUsr).whenComplete(() => null).then((value) => print(value.statusCode));
    }
  }


  MyApp({Key key, @required AuthService authService})
      : assert(authService != null),
        _authService = authService,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(
          create: (_) => UserService.create(),
          dispose: (context, UserService service) => service.client.dispose(),
        ),

      ],
      child: MaterialApp(
        home:  BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
          if (state is Unauthenticated) {
            return Authenticate(authService: _authService);
          }
          if (state is Authenticated) {
            // Want to check weather user exists in our server
            var theMap = new Map<dynamic, dynamic>();
            // TODO: this is for adding user to our server need to fix a bit of logic and
            //
            _authService.getUser().whenComplete(() => null).then(
                (value){
              theMap["UUID"] = value.uid;
              this._uuid = value.uid;
              var prov = Provider.of<UserService>(context,listen: false);
              final response = prov.getUser(theMap);
              response.whenComplete(() => null).then((value2) => _checkResponse(value2, prov, value));
            });

            return Home(uid: _uuid,);
          }
          return SplashScreen();
        }),
      ),
    );
  }
}
