//import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
import 'package:your_list_flutter_app/models/item_model/itemService.dart';
import 'package:your_list_flutter_app/models/list_model/listService.dart';
import 'package:your_list_flutter_app/models/list_model/locationService.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:your_list_flutter_app/screens/authenticate/login_bloc/bloc.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';
import 'package:your_list_flutter_app/screens/home/list_bloc/bloc.dart';
import 'package:your_list_flutter_app/screens/splash_screen.dart';
import 'package:http/http.dart' as http;


import 'home_list.dart';
import 'item_bloc/item_bloc.dart';
import 'item_bloc/item_event.dart';

//import 'package:your_list_flutter_app/models/built_post.dart';
//import 'package:built_collection/built_collection.dart';

class Home extends StatelessWidget {
//  final AuthService _auth = AuthService();
  final String uid;
  var theMap = new Map<dynamic, dynamic>();

  Home({@required this.uid});
//  {
//    theMap["UUID"] = uid;
//  }

  @override
  Widget build(BuildContext context) {
    // Will need to apply bloc patter here just like in main and decide
    // where to go using bloc patter

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: AppColors.mainAppColor,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.account_circle),
            label: Text('logout'),
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          ),
        ],
      ),
      body: MultiProvider(
        providers: [
          BlocProvider<HomeListBloc>(
            create: (context) => HomeListBloc(),
          ),
          Provider(
            create: (_) => ListService.create(),
            dispose: (context, ListService service) => service.client.dispose(),
          ),
          Provider(
            create: (_) => LocationService.create(),
            dispose: (context, LocationService service) => service.client.dispose(),
          ),
          BlocProvider<ListBloc>(
            create:(context) => ListBloc(context: context, lst:  ListService.create(), location: LocationService.create(), uuid: this.uid)..add(Fetch()),
          ),
          Provider(
            create: (_) => ItemService.create(),
            dispose: (context, ItemService service) => service.client.dispose(),
          ),
          BlocProvider<ItemBloc>(
            create:(context) => ItemBloc(context: context, item:  ItemService.create(), uuid: this.uid),
          ),
        ],
        child: BlocBuilder<HomeListBloc, HomeListState>(
          builder: (context, state) {
            if (state is ListState) {
              return HomeList(theMap: this.theMap, uid: this.uid);
            }
            if (state is SearchState) {
              print("Not implemented");
            }
            if (state is UserState) {
              print("Not implemented");
            }
            return SplashScreen();
          },
        ),
      ),
    );
  }
}
