import 'package:flutter/material.dart';


/// Screen created to be used when app goes from
/// authenticated state to home state, so that it can load
/// all of the required information
class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Splash Screen')),
    );
  }
}
