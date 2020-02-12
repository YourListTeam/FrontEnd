import 'package:your_list_flutter_app/screens/authenticate/authGeneral.dart';
import 'package:your_list_flutter_app/screens/authenticate/register.dart';
import 'package:your_list_flutter_app/screens/authenticate/sign_in.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  bool goToEmail = false;
  void toggleView(){
    //print(showSignIn.toString());
    setState(() => showSignIn = !showSignIn);
  }
  void toggleTypeToEmail(){
    setState(() => goToEmail = !goToEmail);
  }

  @override
  Widget build(BuildContext context) {
    if ( goToEmail) {
      if (showSignIn) {
        return SignIn(toggleView:  toggleView, toggleTypeToEmail: toggleTypeToEmail);
      } else {
        return Register(toggleView:  toggleView, toggleTypeToEmail: toggleTypeToEmail);
      }
    } else {
      return GeneralAuth(toggleTypeToEmail: toggleTypeToEmail);
    }
  }
}