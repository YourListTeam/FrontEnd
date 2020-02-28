import 'package:provider/provider.dart';

//import 'package:chopper/chopper.dart';
import 'package:your_list_flutter_app/models/userService.dart';
import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';

//import 'package:your_list_flutter_app/models/built_post.dart';
//import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;

class Home extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: AppColors.backgroundColor,
          appBar: AppBar(
            title: Text('Home'),
            backgroundColor: AppColors.mainAppColor,
            elevation: 0.0,
            actions: <Widget>[
              FlatButton.icon(
                icon: Icon(Icons.account_circle),
                label: Text('logout'),
                onPressed: () async {
                  await _auth.signOut();
                },
              ),
            ],
          ),
//          body: FutureBuilder<Response<BuiltList<BuiltPost>>>(
//            // In real apps, use some sort of state management (BLoC is cool)
//            // to prevent duplicate requests when the UI rebuilds
//            future: Provider.of<UserService>(context).getPosts(),
//            builder: (context, snapshot) {
//              if (snapshot.connectionState == ConnectionState.done) {
//                if (snapshot.hasError) {
//                  return Center(
//                    child: Text(
//                      snapshot.error.toString(),
//                      textAlign: TextAlign.center,
//                      textScaleFactor: 1.3,
//                    ),
//                  );
//                }
//
//                final posts = snapshot.data.body;
//                print(posts);
//                return _buildPosts(context, posts);
//              } else {
//                // Show a loading indicator while waiting for the posts
//                return Center(
//                  child: CircularProgressIndicator(),
//                );
//              }
//            },
//          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () async {
              var theMap = new Map<dynamic, dynamic>();
              theMap["UUID"] = "d4cca862-6a4a-4020-9034-da6e4fcc12c4";
              final responce = Provider.of<UserService>(context).getUser(theMap);
              AsyncSnapshot<http.Response> snapshot;
              responce.then((value) => print(value.body));
            },
            tooltip: 'test responce',
            child: Icon(Icons.add),
          )),
    );
  }
}
