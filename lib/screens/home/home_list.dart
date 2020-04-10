
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/models/list_model/built_myList.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';
import 'package:your_list_flutter_app/screens/home/listadd.dart';

import 'display_list.dart';
import 'item_bloc/item_bloc.dart';
import 'list_bloc/bloc.dart';

/// Main state for ui connected to list state
/// here is where all posts created, or shared with the user will be displayed
///
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
                return PostWidget(post: state.posts[index], uid: this.uid);
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
              MaterialPageRoute(builder: (context) => AddListScreen(addRepository: _postBloc.lst, locRepository: _postBloc.location, uid: uid)),
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

hexStringToHexInt(String hex) {
  print(hex);
  int val;
  try {
    hex = hex.replaceFirst('#', '');
    hex = hex.length == 6 ? '55' + hex : hex;
    val = int.parse(hex, radix: 16);
  } catch (_) {
    val = 0;
  }
  return val;
}

class PostWidget extends StatelessWidget {
  final UsrList post;
  final String uid;

  const PostWidget({Key key, @required this.post, @required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
          elevation: 4,
          color: Color(hexStringToHexInt(post.hex)),
          child: ListTile(
            title: Text(
              post.title,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Text(
              post.location ?? "",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () => Navigator.push(context,
                    MaterialPageRoute(builder: (_) {
                      return BlocProvider.value(
                        value: BlocProvider.of<ItemBloc>(context),
                        child: DisplayList(post: post, uid: uid));
                    })
                ),
//              onTap: () => print(post.lid),
//                Navigator.push(
//                  context,
//                  MaterialPageRoute(builder: (context) => DisplayList(lid: post.lid, uid: uid)),
//                ), //Todo: On tap move towards single list
          ),
    );
  }
}