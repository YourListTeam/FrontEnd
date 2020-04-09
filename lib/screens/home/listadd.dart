import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
import 'package:your_list_flutter_app/models/lsit_model/listService.dart';
import 'package:your_list_flutter_app/screens/home/listadd_bloc/listadd_bloc.dart';
import 'package:your_list_flutter_app/screens/home/listadd_bloc/listadd_state.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:flutter/material.dart';

//import 'authenticate.dart';
import 'list_bloc/list_bloc.dart';
import 'listadd_bloc/listadd_event.dart';

class AddListScreen extends StatelessWidget {
  final ListService _listService;
  final String uid;

  AddListScreen({Key key, @required ListService addRepository, String uid})
      : assert(addRepository != null),
        _listService = addRepository,
        uid = uid,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.50;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: AppColors.mainAppColor,
        elevation: 0.0,
        title: Text('Add New List'),
        leading: new Container(
          width: cWidth,
        ),
      ),
      body: Center(
        child: BlocProvider<AddBloc>(
          create: (context) => AddBloc(listService: _listService),
          child: Add(listService: _listService, uid: uid),
        ),
      ),
    );
  }
}

class Add extends StatefulWidget {
  final ListService _listService;
  final String uid;

  Add({@required ListService listService, String uid})
      : assert(listService != null),
        _listService = listService,
        uid = uid;

  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  ListService get _listService => widget._listService;
  String get uid => widget.uid;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();

  AddBloc _addBloc;

  bool get isPopulated =>
      _nameController.text.isNotEmpty && _colorController.text.isNotEmpty;

  bool isRegisterButtonEnabled(AddState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _addBloc = BlocProvider.of<AddBloc>(context);
    _nameController.addListener(_onNameChanged);
    _colorController.addListener(_onColorChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddBloc, AddState>(
      listener: (context, state) {
        if (state.isSubmitting) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registering...'),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
        }
        if (state.isSuccess) {
          //BlocProvider.of<AuthenticationBloc>(context).add(LoggedIn());
          Navigator.of(context).pop('Yep!');
        }
        if (state.isFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Registration Failure'),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<AddBloc, AddState>(
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20),
            child: Form(
              child: ListView(
                children: <Widget>[
                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.list),
                      labelText: 'List Name',
                    ),
                    autocorrect: true,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isNameValid ? 'Invalid Name' : null;
                    },
                  ),
                  TextFormField(
                    controller: _colorController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.color_lens),
                      labelText: 'List Color',
                    ),
                    autocorrect: true,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isColorValid ? 'Invalid Color' : null;
                    },
                  ),
                  ButtonTheme(
                      minWidth: 225.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: AppColors.mainButtonColor,
                        child: Text(
                          'Add The List',
                          style: TextStyle(color: Colors.black),
                        ),
                        onPressed: isRegisterButtonEnabled(state)
                            ? _onFormSubmitted
                            : null,
                      )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _colorController.dispose();
    super.dispose();
  }

  void _onNameChanged() {
    print(this.uid);
    _addBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onColorChanged() {
    _addBloc.add(
      ColorChanged(color: _colorController.text),
    );
  }

  void _onFormSubmitted() {
    _addBloc.add(
      Submitted(
        name: _nameController.text,
        color: _colorController.text,
        uid: uid
      ),
    );
  }
}
