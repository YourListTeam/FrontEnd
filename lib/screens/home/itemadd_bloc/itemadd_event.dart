import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class ItemAddEvent extends Equatable {
  const ItemAddEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends ItemAddEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class Submitted extends ItemAddEvent {
  final String name;
  final String uid;
  final String lid;

  const Submitted({
    @required this.name,
    @required this.uid,
    @required this.lid,
  });

  @override
  List<Object> get props => [name, uid, lid];

  @override
  String toString() {
    return 'Submitted { name: $name }';
  }
}
