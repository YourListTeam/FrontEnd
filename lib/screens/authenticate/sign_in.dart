import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';

class SignIn extends StatefulWidget {

  final Function toggleView;
  final Function toggleTypeToEmail;
  SignIn({ this.toggleView, this.toggleTypeToEmail });


  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  String error = '';

  // text field state
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width*0.50;
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainAppColor,
        elevation: 0.0,
        title: Text('Sign in'),
        leading: new Container(
          width: c_width,
          child: new Wrap(
            spacing: 1.0,
            runSpacing: 1.0,
            children: <Widget>[
              IconButton(
                onPressed: () => widget.toggleTypeToEmail(),
                icon: Icon(Icons.arrow_back_ios),
//                label: Text(''),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.account_circle),
            label: Text('Register'),
            onPressed: () => widget.toggleView(),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                validator: (val) => val.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0),
              TextFormField(
                obscureText: true,
                validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
                onChanged: (val) {
                  setState(() => password = val);
                },
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: AppColors.mainButtonColor,
                child: Text(
                  'Sign In',
                  style: TextStyle(color: AppColors.buttonTextColor),
                ),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                    if(result == null) {
                      setState(() {
                        error = 'Could not sign in with those credentials';
                      });
                    }
                  }
                }
              ),
              SizedBox(height: 12.0),
              Text(
                error,
                style: TextStyle(color: Colors.black, fontSize: 14.0),
              ),
            ],
          ),
        ),
      ),
    );
  }
}