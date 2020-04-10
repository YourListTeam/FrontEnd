import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:your_list_flutter_app/models/item_model/built_myItem.dart';
import 'package:your_list_flutter_app/models/item_model/itemService.dart';
import 'package:your_list_flutter_app/screens/home/item_bloc/bloc.dart';

class ItemBloc extends Bloc<ItemEvent, UsrItemState> {
  final BuildContext context;
  String uuid;
  final ItemService item;

  ItemBloc(
      { @required this.context, @required this.item, @required this.uuid});

  @override
  Stream<UsrItemState> transformEvents(
    Stream<ItemEvent> events,
    Stream<UsrItemState> Function(ItemEvent event) next,
  ) {
    return super.transformEvents(
      events.debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => UsrItemUninitialized();

  @override
  Stream<UsrItemState> mapEventToState(ItemEvent event) async* {
    final currentState = state;
    if (event is ItemFetch) {
      try {
        if (currentState is UsrItemUninitialized) {
          final posts = await _fetchPosts(event.props[0]);
          yield PostLoaded(posts: posts);
          return;
        }
      } catch (_) {
        yield PostError();
        return;
      }
    }
    if (event is SubmitItem) {
      final response = await item.putItem(currentState.getMap());
      print(response);
      if (response.statusCode == 200) {
        yield UsrItemUninitialized();
        return;
      } else {
        yield currentState;
        return;
      }
    }
  }

  Future<List<UsrItem>> _fetchPosts(String lid) async {
    Map<dynamic, dynamic> body = new Map();
    body["UUID"] = this.uuid;
    body["LID"] = lid;
    final response2 = await item.getItems(body);
    if( response2.statusCode == 200) {
      List<Map<dynamic, dynamic>> value1 = response2.body;
      List<UsrItem> my = new List();
      for (var i = 0; i < value1.length; i++) {
        my.add(new UsrItem(
            lid: value1[i]["lid"],
            uuid: value1[i]["uuid"],
            iid: value1[i]["iid"],
            name: value1[i]["name"],
            completed: value1[i]["completed"],
            modified: value1[i]["modified"],
        ));
      }
      return my;
    } else {
      throw Exception('error fetching posts');
    }
  }
}
