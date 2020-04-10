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

class LocNameChanged extends AddEvent {
  final String locName;

  const LocNameChanged({@required this.locName});

  @override
  List<Object> get props => [locName];

  @override
  String toString() => 'LocNameChanged { color: $locName }';
}

class AddressChanged extends AddEvent {
  final String address;

  const AddressChanged({@required this.address});

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'addressChanged { color: $address }';
}

class Submitted extends AddEvent {
  final String name;
  final String color;
  final String uid;
  final String locName;
  final String address;

  const Submitted({
    @required this.name,
    @required this.color,
    @required this.uid,
    @required this.locName,
    @required this.address,
  });

  @override
  List<Object> get props => [name, color, uid, locName, address];

  @override
  String toString() {
    return 'Submitted { name: $name, color: $color,  locName: $locName, address: $address }';
  }
}


class Updated extends AddEvent {
  final String name;
  final String color;
  final String uid;
  final String locName;
  final String address;

  const Updated({
    @required this.name,
    @required this.color,
    @required this.uid,
    @required this.locName,
    @required this.address,
  });

  @override
  List<Object> get props => [name, color, uid, locName, address];

  @override
  String toString() {
    return 'Updated { name: $name, color: $color,  locName: $locName, address: $address }';
  }
}