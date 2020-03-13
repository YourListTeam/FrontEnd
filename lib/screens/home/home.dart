//import 'package:chopper/chopper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/screens/home/contactspage.dart';
//import 'package:provider/provider.dart';
import 'dart:async';
import 'profilepage.dart';
import 'listspage.dart';
//import 'package:chopper/chopper.dart';
//import 'package:your_list_flutter_app/models/userService.dart';
//import 'package:your_list_flutter_app/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:your_list_flutter_app/models/userService.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';

//import 'package:your_list_flutter_app/models/built_post.dart';
//import 'package:built_collection/built_collection.dart';

class Home extends StatelessWidget {
//  final AuthService _auth = AuthService();

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
            onPressed: () {
              BlocProvider.of<AuthenticationBloc>(context).add(
                LoggedOut(),
              );
            },
          ),
        ],
      ),
      body: MyStatefulWidget(),
    )
//

        );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    ListsPage(),
    ContactsPage(),
    ProfilePage(),
  ];
  void _bottomNavTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.contacts),
            title: Text("Contacts"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            title: Text("Profile"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _bottomNavTapped,
      ),
    );
  }
}
