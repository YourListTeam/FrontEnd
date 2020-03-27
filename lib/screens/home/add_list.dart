import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:your_list_flutter_app/models/lsit_model/built_myList.dart';
import 'package:your_list_flutter_app/screens/home/home_bloc/bloc.dart';

import 'list_bloc/bloc.dart';

class AddList extends StatefulWidget {
  final String uid;

  AddList({this.uid});

  @override
  State<StatefulWidget> createState() => _AddListState();
}

class _AddListState extends State<AddList> {
  String get uid => widget.uid;

  ListBloc _listBloc;

  @override
  void initState() {
    super.initState();
    _listBloc = BlocProvider.of<ListBloc>(context);
    BlocProvider.of<ListBloc>(context).add(NewList());
  }

  final _formKey = GlobalKey<FormState>();

  _showDialog(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submitting form')));
  }

  _showFail(BuildContext context) {
    Scaffold.of(context)
        .showSnackBar(SnackBar(content: Text('Submit Failed')));
  }

  @override
  Widget build(BuildContext context) {
      return BlocBuilder<ListBloc, UsrListState>(
        builder: (context, state) {
          if (state is UsrListUninitialized) {
            print(state);
            BlocProvider.of<HomeListBloc>(context).add(SwitchToHomeList());
            return Center(
              child: Text('success'),
            );
          } else if (state is NewForm) {
              return new Container (
                  margin: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                  child: Form( key: _formKey,
                      child: Column(
                          children: <Widget>[
                            Text('Create New List', style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0)),
                            TextFormField(
                                decoration: InputDecoration(labelText: 'List Name'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Please enter some text';
                                  }
                                return null;
                                },
                              onSaved: (val) => state.name = val,
                            ),
                            TextFormField(
                              decoration: InputDecoration(labelText: 'List Color'),
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter some text';
                                }
                                return null;
                              },
                              onSaved: (val) => state.color = val,
                            ),
                            RaisedButton(
                              onPressed: () {
                                final form = _formKey.currentState;
                                if (form.validate()) {
                                  form.save();
                                  _showDialog(context);
                                  BlocProvider.of<ListBloc>(context).add(SubmitList());
                                }
                              },
                              child: Text('Save'),
                            ),
                          ]
                      )
                  )
              );
          } else {
              return Center(
                child: Text(''),
              );
          }
        },
      );
    }
  }