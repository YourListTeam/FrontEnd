import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ItemFetch extends ItemEvent {
  final String lid;
  ItemFetch({this.lid});
  @override
  List<Object> get props => [lid];

  @override
  String toString() {
    return 'ItemFetch { name: $lid }';
  }
}

class SubmitItem extends ItemEvent {}