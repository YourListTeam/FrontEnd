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
  runApp(
    BlocProvider(
        create: (context) => AuthenticationBloc(
            authService: authService
        )..add(AppStarted()),
        child:MyApp(authService: authService),
    )
);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final AuthService _authService;
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
        ), // UserApi
      ],
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, state) {
              if(state is Unauthenticated){
                return Authenticate(authService: _authService);
              }
              if (state is Authenticated){
                return Home();
              }
              return SplashScreen();
            }
        ),
      ),
    );

  }
}
