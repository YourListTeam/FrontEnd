import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
import 'package:your_list_flutter_app/models/item_model/built_myItem.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';

import 'item_bloc/item_bloc.dart';
import 'item_bloc/bloc.dart';

class DisplayList extends StatefulWidget {
  final String uid;
  final String lid;
  final String name;

  DisplayList({this.lid, this.uid, this.name});

  @override
  State<StatefulWidget> createState() => _DisplayListState();
}

class _DisplayListState extends State<DisplayList> {
  String get lid => widget.lid;
  String get uid => widget.uid;
  String get name => widget.name;

  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ItemBloc _itemBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _itemBloc = BlocProvider.of<ItemBloc>(context);
    _itemBloc.add(ItemFetch(lid: lid));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
          backgroundColor: AppColors.mainAppColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.account_circle),
              label: Text('logout'),
              onPressed: () {
                Navigator.pop(context);
                BlocProvider.of<AuthenticationBloc>(context).add(
                  LoggedOut(),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<ItemBloc, UsrItemState>(
        builder: (context, state) {
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.length == 0) {
              return Center(
                child: Text('no posts'),
              );
            }
            return ListView.builder(
              padding: EdgeInsets.all(8),
              itemBuilder: (BuildContext context, int index) {
                return PostWidget(post: state.posts[index]);
              },
              itemCount: state.posts.length,
              controller: _scrollController,
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print('hit');
          },
//          onPressed: () async {
//            final result = await Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => AddListScreen(addRepository: _postBloc.lst, uid: uid)),
//            );
//            _postBloc.add(FreshFetch());
//          },
          tooltip: 'test response',
          child: Icon(Icons.add),
        )
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    if (maxScroll - currentScroll <= _scrollThreshold) {
        print('scrollin');
    }
  }
}

class BottomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: Center(
        child: SizedBox(
          width: 33,
          height: 33,
          child: CircularProgressIndicator(
            strokeWidth: 1.5,
          ),
        ),
      ),
    );
  }
}

class PostWidget extends StatelessWidget {
  final UsrItem post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              post.name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
//            subtitle: ,
            onTap: () =>
                print(post.iid), //Todo: On tap move towards single list

          ),
    );
  }
}