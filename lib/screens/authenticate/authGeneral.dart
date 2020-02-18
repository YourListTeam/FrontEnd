import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_platform_interface/firebase_auth_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:google_sign_in/google_sign_in.dart';


GoogleSignIn _googleSignIn = GoogleSignIn(//  scopes: [
//    'email',
//    'https://www.googleapis.com/auth/contacts.readonly',
//  ],
);
//GoogleSignInOptions gso = new G
final FirebaseAuth _auth = FirebaseAuth.instance;


class GeneralAuth extends StatefulWidget {

  final Function toggleTypeToEmail;
  GeneralAuth({this.toggleTypeToEmail });

  @override
  _GeneralAuthState createState() => _GeneralAuthState();

}

class _GeneralAuthState extends State<GeneralAuth>{



  @override
  void initState() {
    super.initState();
//    initProviders();
  }
//
//  Future<void> initProviders() async {
//    FlutterAuthUi.setEmail();
//    FlutterAuthUi.setApple();
//    FlutterAuthUi.setGithub();
//    FlutterAuthUi.setGoogle();
//    FlutterAuthUi.setMicrosoft();
//    FlutterAuthUi.setYahoo();
//
////    final user = await FlutterAuthUi.startUi();
////    print(user);
//  }


  Future<FirebaseUser> _signInWithGoogle() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      AuthResult result = await _auth.signInWithCredential(credential);
      // Can act here
      return result?.user;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.mainAppColor,
        centerTitle: true,
        title: const Text('Your List'),
      ),
      body: Center(

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please log in to YourList:',
//              style: TextStyle(fontFamily: ),
            ),

            SignInButton(
                Buttons.Google,
                onPressed: _signInWithGoogle
            ),

            SignInButtonBuilder(
              icon: Icons.email,
              text: 'Sign-in with email',
              onPressed: () => widget.toggleTypeToEmail(),
              backgroundColor: AppColors.registerButtonEmailColor,
            ),

          ],
        ),
      ),
    );
  }

}