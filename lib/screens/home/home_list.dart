import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/models/lsit_model/listService.dart';
import 'package:your_list_flutter_app/models/lsit_model/lstBuilt.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';

class HomeList extends StatefulWidget {
  final String uid;
  final Map<dynamic, dynamic> theMap;

  HomeList({this.theMap, this.uid});

  @override
  State<StatefulWidget> createState() => _HomeListState();
}

class _HomeListState extends State<HomeList> {
  Map<dynamic, dynamic> get theMap => widget.theMap;

  String get uid => widget.uid;

  HomeListBloc _homeListBloc;

  @override
  void initState() {
    super.initState();
    _homeListBloc = BlocProvider.of<HomeListBloc>(context);
    // TODO : remove line below is here only for testing purposes
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    Map <dynamic, dynamic> body = new Map <dynamic,dynamic>();
    body["UUID"] = "d4cca862-6a4a-4020-9034-da6e4fcc12c4";
    return FutureBuilder<Response<List<String>>>(
        // In real apps, use some sort of state management (BLoC is cool)
        // to prevent duplicate requests when the UI rebuilds
        future: Provider.of<ListService>(context).getLists(body),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print("wait what");
            if (snapshot.hasError) {
              print(snapshot.error);
              return Center(
                child: Text(
                  snapshot.error.toString(),
                  textAlign: TextAlign.center,
                  textScaleFactor: 1.3,
                ),
              );
            }
            final posts = snapshot.data.body;
            List <BuiltMyList> temp = new List<BuiltMyList>();
            print(posts);
            for(var i =0; i < posts.length; i++) {
              Map <dynamic, dynamic> temp2 = new Map <dynamic,dynamic>();
              // This is purely for testing purposes
              temp2["UUID"] = "d4cca862-6a4a-4020-9034-da6e4fcc12c4";
              temp2["LID"] = posts[i];
              print(temp2);

              // I'm not sure how to call request for each item in and it would wait
              // For each of them to come back
              // this will be more problematic as the list grows
              Provider.of<ListService>(context)
                  .getList(temp2)
                  .then((value){
                    print(value.body);
                    temp.add(BuiltMyList((b) => b..lid = value.body["lid"]
                      ..listname = value.body["listname"]));

                  }
                  );
            }
            return _buildPosts(context, temp);
          } else {
            // Show a loading indicator while waiting for the posts
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },

    );
  }

  ListView _buildPosts(BuildContext context, List<BuiltMyList> posts) {
    return ListView.builder(
      itemCount: posts.length,
      padding: EdgeInsets.all(8),
      itemBuilder: (context, index) {
        return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              posts[index].listname,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
//            subtitle: ,
            onTap: () =>
                print(posts[index].lid), //Todo: create single list state
          ),
        );
      },
    );
  }
}
