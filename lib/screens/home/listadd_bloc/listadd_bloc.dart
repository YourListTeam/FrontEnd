import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:your_list_flutter_app/models/list_model/listService.dart';
import '../../../validators.dart';
import './bloc.dart';



class AddBloc extends Bloc<AddEvent, AddState> {
  final ListService _listService;

  AddBloc({@required ListService listService})
      : assert(listService != null),
        _listService = listService;

  @override
  AddState get initialState => AddState.empty();

  @override
  Stream<AddState> transformEvents(
      Stream<AddEvent> events,
      Stream<AddState> Function(AddEvent event) next,
      ) {
    final nonDebounceStream = events.where((event) {
      return (event is! NameChanged && event is! ColorChanged);
    });
    final debounceStream = events.where((event) {
      return (event is NameChanged || event is ColorChanged);
    }).debounceTime(Duration(milliseconds: 300));
    return super.transformEvents(
      nonDebounceStream.mergeWith([debounceStream]),
      next,
    );
  }

  @override
  Stream<AddState> mapEventToState(
      AddEvent event,
      ) async* {
    if (event is NameChanged) {
      yield* _mapNameChangedToState(event.name);
    } else if (event is ColorChanged) {
      yield* _mapColorChangedToState(event.color);
    } else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.name, event.color, event.uid);
    }
  }

  Stream<AddState> _mapNameChangedToState(String name) async* {
    yield state.update(
      isNameValid: Validators.isValidListName(name),
    );
  }

  Stream<AddState> _mapColorChangedToState(String color) async* {
    yield state.update(
      isColorValid: Validators.isValidColor(color),
    );
  }

  Stream<AddState> _mapFormSubmittedToState(
      String name,
      String color,
      String uid,
      ) async* {
    yield AddState.loading();
    try {
      Map<dynamic, dynamic> map = new Map();
      map['listname'] = name;
      map['Color'] = color;
      map['UUID'] = uid;
      await _listService.postList(map);
      yield AddState.success();
    } catch (_) {
      yield AddState.failure();
    }
  }
}

