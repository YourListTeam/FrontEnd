import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

abstract class AddEvent extends Equatable {
  const AddEvent();

  @override
  List<Object> get props => [];
}

class NameChanged extends AddEvent {
  final String name;

  const NameChanged({@required this.name});

  @override
  List<Object> get props => [name];

  @override
  String toString() => 'NameChanged { name :$name }';
}

class ColorChanged extends AddEvent {
  final String color;

  const ColorChanged({@required this.color});

  @override
  List<Object> get props => [color];

  @override
  String toString() => 'ColorChanged { color: $color }';
}

class Submitted extends AddEvent {
  final String name;
  final String color;
  final String uid;

  const Submitted({
    @required this.name,
    @required this.color,
    @required this.uid,
  });

  @override
  List<Object> get props => [name, color, uid];

  @override
  String toString() {
    return 'Submitted { name: $name, color: $color }';
  }
}
