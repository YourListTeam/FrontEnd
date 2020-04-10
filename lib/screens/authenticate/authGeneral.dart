//import 'dart:async';
import 'package:flutter/material.dart';
//import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
//import 'package:your_list_flutter_app/models/userService.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:your_list_flutter_app/screens/authenticate/register.dart';
import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_bloc/login_bloc.dart';
import 'login_bloc/login_event.dart';
import 'login_bloc/login_state.dart';
/// Main log in ui which mostly controls when infromation is sent to the server
/// as well as checking for passwords and email validity using regex
class GeneralAuth extends StatefulWidget {
  final AuthService _authService;

  GeneralAuth({@required AuthService authService})
      : assert(authService != null),
        _authService = authService;

  @override
  _GeneralAuthState createState() => _GeneralAuthState();
}

class _GeneralAuthState extends State<GeneralAuth> {
  AuthService get _authService => widget._authService;
  final _formKey = GlobalKey<FormState>();
  String error = '';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  LoginBloc _loginBloc;

  bool get isPopulated =>
      _emailController.text.isNotEmpty && _passwordController.text.isNotEmpty;

  bool isLoginButtonEnabled(LoginState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _loginBloc = BlocProvider.of<LoginBloc>(context);
    _emailController.addListener(_onEmailChanged);
    _passwordController.addListener(_onPasswordChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state.isFailure) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Login Failure'), Icon(Icons.error)],
              ),
              backgroundColor: Colors.red,
            ),
          );
      }
      if (state.isSubmitting) {
        Scaffold.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            SnackBar(
              content: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Logging In...'),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          );
      }
      if (state.isSuccess) {
        BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            backgroundColor: AppColors.mainAppColor,
            centerTitle: true,
            title: const Text('Your List'),
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.account_circle),
                label: Text('Register'),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) {
                      return RegisterScreen(userRepository: _authService);
                    }),
                  );
                },
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.symmetric(vertical: 18.0, horizontal: 45.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Text(
                    'Please log in to YourList:',
  //              style: TextStyle(fontFamily: ),
                  ),
                  TextFormField(
  //                validator: (val) => val.isEmpty ? 'Enter an email' : null,
  //                onChanged: (val) {
  //                  setState(() => email = val);
  //                },
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isEmailValid ? 'Invalid Email' : null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    autovalidate: true,
                    autocorrect: false,
                    validator: (_) {
                      return !state.isPasswordValid ? 'Invalid Password' : null;
                    },
                  ),
                  SizedBox(height: 10.0),
                  ButtonTheme(
                      minWidth: 225.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: AppColors.mainButtonColor,
                        child: Text(
                          'Sign In',
                          style: TextStyle(color: AppColors.buttonTextColor),
                        ),
                        onPressed: isLoginButtonEnabled(state)
                          ? _onFormSubmitted
                          : null,
                      )),

                  SizedBox(height: 10.0),
                  SignInButton(
                      Buttons.Google,
                      onPressed: () {
                    BlocProvider.of<LoginBloc>(context).add(
                      LoginWithGooglePressed(),
                    );
                  }),
  //                SignInButtonBuilder(
  //                  icon: Icons.email,
  //                  text: 'Sign-in with email',
  //                  onPressed: () => widget.toggleTypeToEmail(),
  //                  backgroundColor: AppColors.registerButtonEmailColor,
  //                ),
                ],
              ),
            ),
          ),
        );
    }));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onEmailChanged() {
    _loginBloc.add(
      EmailChanged(email: _emailController.text),
    );
  }

  void _onPasswordChanged() {
    _loginBloc.add(
      PasswordChanged(password: _passwordController.text),
    );
  }

  void _onFormSubmitted() {
    _loginBloc.add(
      LoginWithCredentialsPressed(
        email: _emailController.text,
        password: _passwordController.text,
      ),
    );
  }
}
