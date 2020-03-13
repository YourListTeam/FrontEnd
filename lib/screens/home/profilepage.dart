import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/models/userService.dart';

// I/flutter ( 8277): {uuid: SSbxpzNSCFSCxpvafwaJuKftgBM2, username: JPMoreno, name: JP, homelocation: null, email: jpmoreno26@gmail.com, picture: null}

class User {
  final String uuid;
  final String username;
  final String name;
  final String home;
  final String email;
  final String picture;

  User(
      {this.uuid,
      this.username,
      this.name,
      this.home,
      this.email,
      this.picture});

  factory User.fromJson(Map<String, String> json) {
    print(json);
    return User(
        uuid: json["UUID"],
        username: json["username"],
        name: json["name"],
        home: json["homelocation"],
        email: json["email"],
        picture: json["picture"]);
  }
}

Future<User> getUser() async {
  var body = {"UUID": "SSbxpzNSCFSCxpvafwaJuKftgBM2"};
  var us = UserService.create();
  final res = await us.getUser(body);
  return User(
      uuid: res.body["UUID"],
      username: res.body["username"],
      name: res.body["name"],
      home: res.body["homelocation"],
      email: res.body["email"],
      picture: res.body["picture"]);
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Future<User> futureUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureUser = getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(100.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(Icons.account_circle, size: 60),
          Container(
              padding: EdgeInsets.all(20.0),
              child: FutureBuilder<User>(
                future: futureUser,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    print(snapshot.data);
                    return Column(
                      children: [
                        Text("Username: " + snapshot.data.username),
                        Text("Name: " + snapshot.data.name),
                      ],
                    );
                    Text("Username: " + snapshot.data.username);
                  }
                  return CircularProgressIndicator();
                },
              ))
        ],
      ),
    );
  }
}
