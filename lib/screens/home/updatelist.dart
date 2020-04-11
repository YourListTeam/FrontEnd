import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
import 'package:your_list_flutter_app/models/list_model/built_myList.dart';
import 'package:your_list_flutter_app/models/list_model/listService.dart';
import 'package:your_list_flutter_app/models/list_model/locationService.dart';
import 'package:your_list_flutter_app/screens/home/listadd_bloc/listadd_bloc.dart';
import 'package:your_list_flutter_app/screens/home/listadd_bloc/listadd_state.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:flutter/material.dart';

//import 'authenticate.dart';
import 'list_bloc/list_bloc.dart';
import 'listadd_bloc/listadd_event.dart';

class UpdateListScreen extends StatelessWidget {
  final ListService _listService;
  final String uid;
  final LocationService _locationService;
  final UsrList post;

  UpdateListScreen({Key key, @required ListService addRepository, String uid, @required LocationService locRepository, @required UsrList post})
      : assert(addRepository != null),
        _listService = addRepository,
        uid = uid,
        _locationService = locRepository,
        post = post,
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
          create: (context) => AddBloc(listService: _listService, locationService: _locationService),
          child: Update(uid: uid, list: post),
        ),
      ),
    );
  }
}

class Update extends StatefulWidget {
  final String uid;
  final UsrList list;

  Update({String uid, UsrList list})
      : uid = uid,
        list = list;

  State<Update> createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  String get uid => widget.uid;
  UsrList get list => widget.list;
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _colorController = TextEditingController();
  final TextEditingController _locNameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
    _locNameController.addListener(_onLocNameChanged);
    _addressController.addListener(_onAddressChanged);
    _nameController.text = list.title;
    _colorController.text = list.colour;
    _locNameController.text = list.location ?? "";
    _addressController.text = list.address ?? "";

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
                    Text('Patch Failure'),
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
                  TextFormField(
                    controller: _locNameController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.add_location),
                      labelText: 'List Location',
                    ),
                    autocorrect: true,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isLocNameValid ? 'Invalid Location' : null;
                    },
                  ),
                  TextFormField(
                    controller: _addressController,
                    decoration: InputDecoration(
                      icon: state.isAddressValid ? Icon(Icons.gps_fixed) : Icon(Icons.gps_not_fixed),
                      labelText: 'Location Address',
                    ),
                    autocorrect: true,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isAddressValid ? 'Invalid Address' : null;
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

  void _onLocNameChanged() {
    _addBloc.add(
      LocNameChanged(locName: _locNameController.text),
    );
  }

  void _onAddressChanged() {
    _addBloc.add(
      AddressChanged(address: _addressController.text),
    );
  }

  void _onFormSubmitted() {
    _addBloc.add(
      Updated(
        name: _nameController.text,
        color: _colorController.text,
        locName: _locNameController.text,
        address: _addressController.text,
        uid: uid
      ),
    );
  }
}
