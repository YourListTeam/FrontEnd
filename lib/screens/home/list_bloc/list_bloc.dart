import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:your_list_flutter_app/models/lsit_model/built_myList.dart';
import 'package:your_list_flutter_app/models/lsit_model/listService.dart';
import 'package:your_list_flutter_app/screens/home/list_bloc/bloc.dart';

class ListBloc extends Bloc<ListEvent, UsrListState> {
  final BuildContext context;
  String uuid;
  final ListService lst;

  ListBloc(
      { @required this.context, @required this.lst, @required this.uuid});

  @override
  Stream<UsrListState> transformEvents(
    Stream<ListEvent> events,
    Stream<UsrListState> Function(ListEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => UsrListUninitialized();

  @override
  Stream<UsrListState> mapEventToState(ListEvent event) async* {
    final currentState = state;
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is UsrListUninitialized) {
          final posts = await _fetchPosts(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final posts = await _fetchPosts(currentState.posts.length, 20);
          print(posts.length);
          yield posts.isEmpty
              ? currentState.copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: currentState.posts + posts,
                  hasReachedMax: false,
                );
        }
      } catch (_) {
        yield PostError();
        return;
      }
    }
    if (event is FreshFetch) {
      try {
        final posts = await _fetchPosts(0, 20);
        yield PostLoaded(posts: posts, hasReachedMax: false);
        return;
      } catch (_) {
        yield PostError();
        return;
      }
    }
    if (event is NewList) {
        yield NewForm(uid: this.uuid);
        return;
    }
    if (event is SubmitList) {
      final response = await lst.postList(currentState.getMap());
      print(response);
      if (response.statusCode == 200) {
        yield UsrListUninitialized();
        return;
      } else {
        yield currentState;
        return;
      }
    }
  }

  bool _hasReachedMax(UsrListState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<UsrList>> _fetchPosts(int startIndex, int limit) async {
    Map<dynamic, dynamic> body = new Map();
    body["UUID"] = this.uuid;
    final response2 = await lst.getLists(body);
    if( response2.statusCode == 200) {
      List<String> value1 = response2.body;

      List<UsrList> my = new List();
      for (var i = startIndex; i < value1.length; i++) {
        body["LID"] = value1[i];
        final l = await lst.getList(body);
        if (l.statusCode == 200) {
          my.add(new UsrList(
              lid: l.body["lid"],
              title: l.body["listname"],
              colour: l.body["colour"],
              date: l.body["modified"]
          ));
        }
      }
      return my;
    } else {
      throw Exception('error fetching posts');
    }
  }
}
