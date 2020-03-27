import 'package:equatable/equatable.dart';

abstract class ListEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Fetch extends ListEvent {}

class NewList extends ListEvent {}

class SubmitList extends ListEvent {}