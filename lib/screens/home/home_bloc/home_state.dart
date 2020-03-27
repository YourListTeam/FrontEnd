import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomeListState extends Equatable {
  const HomeListState();

  @override
  List<Object> get props => [];
}

class ListState extends HomeListState {}

class UserState extends HomeListState {} //TODO: Implement the state

class SearchState extends HomeListState {} //TODO: Implement the state

class ListAdd extends HomeListState {} //TODO: Implement the state
