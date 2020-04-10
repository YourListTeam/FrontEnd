import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:chopper/chopper.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:your_list_flutter_app/models/list_model/listService.dart';
import 'package:your_list_flutter_app/models/list_model/locationService.dart';
import '../../../validators.dart';
import './bloc.dart';


class AddBloc extends Bloc<AddEvent, AddState> {
  final ListService _listService;
  final LocationService _locationService;

  AddBloc({@required ListService listService, LocationService locationService})
      : assert(listService != null),
        _listService = listService,
        _locationService = locationService;

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
    } else if (event is LocNameChanged) {
      yield* _mapLocNameChangedToState(event.locName);
    }else if (event is AddressChanged) {
      yield* _mapAddressChangedToState(event.address);
    }else if (event is Submitted) {
      yield* _mapFormSubmittedToState(event.name, event.color, event.uid, event.locName, event.address);
    }else if (event is Updated) {
      yield* _mapFormUpdatedToState(event.name, event.color, event.uid, event.locName, event.address);
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

  Stream<AddState> _mapLocNameChangedToState(String locName) async* {
    yield state.update(
      isLocNameValid: Validators.isValidLocation(locName),
    );
  }

  Stream<AddState> _mapAddressChangedToState(String address) async* {
    yield state.update(
      isAddressValid: Validators.isValidListName(address),
    );
  }

  Stream<AddState> _mapFormSubmittedToState(
      String name,
      String color,
      String uid,
      String locName,
      String address,
      ) async* {
    yield AddState.loading();
    try {
      Map<dynamic, dynamic> map = new Map();
      map['listname'] = name;
      map['Color'] = color;
      map['UUID'] = uid;
      map['Address'] = address;
      map['Name'] = locName;
      Response res = await _listService.postList(map);
      if (res.statusCode == 200) {
        map['LID'] = res.body['lid'];
        try {
          await _locationService.postLocation(map);
          yield AddState.success();
        } catch (_) {
          await _listService.deleteList(map);
          yield AddState.failure();
        }
      } else {
        yield AddState.failure();
      }
    } catch (_) {
      yield AddState.failure();
    }
  }

  Stream<AddState> _mapFormUpdatedToState(
      String name,
      String color,
      String uid,
      String locName,
      String address,
      ) async* {
    yield AddState.loading();
    try {
      Map<dynamic, dynamic> map = new Map();
      map['listname'] = name;
      map['Color'] = color;
      map['UUID'] = uid;
      map['Address'] = address;
      map['Name'] = locName;
      yield AddState.success();
//      Response res = await _listService.postList(map);
//      if (res.statusCode == 200) {
//        map['LID'] = res.body['lid'];
//        try {
//          await _locationService.postLocation(map);
//          yield AddState.success();
//        } catch (_) {
//          await _listService.deleteList(map);
//          yield AddState.failure();
//        }
//      } else {
//        yield AddState.failure();
//      }
    } catch (_) {
      yield AddState.failure();
    }
  }
}

