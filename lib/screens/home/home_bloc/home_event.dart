import 'package:equatable/equatable.dart';

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