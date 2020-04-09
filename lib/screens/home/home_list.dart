import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/models/lsit_model/built_myList.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';
import 'package:your_list_flutter_app/screens/home/listadd.dart';

import 'list_bloc/bloc.dart';

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
  final _scrollController = ScrollController();
  final _scrollThreshold = 200.0;
  ListBloc _postBloc;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _postBloc = BlocProvider.of<ListBloc>(context);
    _postBloc.add(Fetch());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocBuilder<ListBloc, UsrListState>(
        builder: (context, state) {
          if (state is PostError) {
            return Center(
              child: Text('failed to fetch posts'),
            );
          }
          if (state is PostLoaded) {
            if (state.posts.isEmpty) {
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
//          onPressed: () async {
//            BlocProvider.of<HomeListBloc>(context).add(SwitchToListAdd());
//          },
          onPressed: () async {
            final result = await Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AddListScreen(addRepository: _postBloc.lst, uid: uid)),
            );
            _postBloc.add(FreshFetch());
          },
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
      _postBloc.add(Fetch());
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
  final UsrList post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 4,
          child: ListTile(
            title: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
//            subtitle: ,
            onTap: () =>
                print(post.lid), //Todo: On tap move towards single list

          ),
    );
  }
}