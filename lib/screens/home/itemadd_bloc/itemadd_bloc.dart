import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:your_list_flutter_app/models/item_model/itemService.dart';
import '../../../validators.dart';
import './bloc.dart';



class ItemAddBloc extends Bloc<ItemAddEvent, ItemAddState> {
  final ItemService _itemService;

  ItemAddBloc({@required ItemService itemService})
      : assert(itemService != null),
        _itemService = itemService;

  @override
  ItemAddState get initialState => ItemAddState.empty();

  @override
  Stream<ItemAddState> transformEvents(
      Stream<ItemAddEvent> events,
      Stream<ItemAddState> Function(ItemAddEvent event) next,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! NameChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NameChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<ItemAddState> mapEventToState(
      ItemAddEvent event,
      ) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.name, event.uid, event.lid);
    }
  }

  Stream<ItemAddState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.isValidListName(name),
    );
  }

  Stream<ItemAddState> _mapFormSubmittedToState(
      String name,
      String uid,
      String lid,
      ) async* {
    yield ItemAddState.loading();
    try {
      Map<dynamic, dynamic> map = new Map();
      map['Name'] = name;
      map['UUID'] = uid;
      map['LID'] = lid;
      Response res = await _itemService.putItem(map);
      if (res.statusCode == 200) yield ItemAddState.success();
      else if (res.statusCode == 401) yield ItemAddState.badPerms();
      else yield ItemAddState.failure();
    } catch (_) {
      yield ItemAddState.failure();
    }
  }
}

