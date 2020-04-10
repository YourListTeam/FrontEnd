import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:your_list_flutter_app/authentication_block/authentication_bloc.dart';
import 'package:your_list_flutter_app/models/item_model/itemService.dart';
import 'package:your_list_flutter_app/screens/home/itemadd_bloc/itemadd_bloc.dart';
import 'package:your_list_flutter_app/res/val/colors.dart';
import 'package:flutter/material.dart';

//import 'authenticate.dart';
import 'itemadd_bloc/itemadd_state.dart';
import 'itemadd_bloc/itemadd_event.dart';

class AddItemScreen extends StatelessWidget {
  final ItemService _itemService;
  final String uid;
  final String lid;

  AddItemScreen({Key key, @required ItemService addRepository, String uid, String lid})
      : assert(addRepository != null),
        _itemService = addRepository,
        uid = uid,
        lid = lid,
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
        child: BlocProvider<ItemAddBloc>(
          create: (context) => ItemAddBloc(itemService: _itemService),
          child: Add(itemService: _itemService, uid: uid, lid: lid),
        ),
      ),
    );
  }
}

class Add extends StatefulWidget {
  final ItemService _itemService;
  final String uid;
  final String lid;

  Add({@required ItemService itemService, String uid, String lid})
      : assert(itemService != null),
        _itemService = itemService,
        uid = uid,
        lid = lid;

  State<Add> createState() => _AddState();
}

class _AddState extends State<Add> {
  ItemService get _itemService => widget._itemService;
  String get uid => widget.uid;
  String get lid => widget.lid;
  final TextEditingController _nameController = TextEditingController();

  ItemAddBloc _itemAddBloc;

  bool get isPopulated =>
      _nameController.text.isNotEmpty;

  bool isRegisterButtonEnabled(ItemAddState state) {
    return state.isFormValid && isPopulated && !state.isSubmitting;
  }

  @override
  void initState() {
    super.initState();
    _itemAddBloc = BlocProvider.of<ItemAddBloc>(context);
    _nameController.addListener(_onNameChanged);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ItemAddBloc, ItemAddState>(
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
                    Text(state.errorMsg),
                    Icon(Icons.error),
                  ],
                ),
                backgroundColor: Colors.red,
              ),
            );
        }
      },
      child: BlocBuilder<ItemAddBloc, ItemAddState>(
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
                      labelText: 'Item Name',
                    ),
                    autocorrect: true,
                    autovalidate: true,
                    validator: (_) {
                      return !state.isNameValid ? 'Invalid Name' : null;
                    },
                  ),
                  ButtonTheme(
                      minWidth: 225.0,
                      height: 40.0,
                      child: RaisedButton(
                        color: AppColors.mainButtonColor,
                        child: Text(
                          'Add An Item',
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
    super.dispose();
  }

  void _onNameChanged() {
    print(this.uid);
    _itemAddBloc.add(
      NameChanged(name: _nameController.text),
    );
  }

  void _onFormSubmitted() {
    _itemAddBloc.add(
      Submitted(
        name: _nameController.text,
        uid: uid,
        lid: lid
      ),
    );
  }
}
