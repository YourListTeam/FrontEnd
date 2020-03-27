import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';

class HomeListBloc extends Bloc<HomeListEvent, HomeListState> {
  @override
  HomeListState get initialState => ListState();

  @override
  Stream<HomeListState> mapEventToState(
    HomeListEvent event,
  ) async* {
    if(event is SwitchToHomeList){
      yield ListState();
    } else if (event is SwitchToContacts){
      throw UnimplementedError("Contacts state not implemeted");
    } else if (event is SwitchToPreferences){
      throw UnimplementedError("Preferences state not implemented");
    } else if (event is SwitchToListAdd) {
      yield ListAdd();
    }
  }
}
