import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

abstract class HomeListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RequestListUpdate extends HomeListEvent{
  // Can only be requested from
}

class SwitchToHomeList extends HomeListEvent {}

class SwitchToContacts extends HomeListEvent {}

class SwitchToPreferences extends HomeListEvent {}

class SwitchToListAdd extends HomeListEvent {}