
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:equatable/equatable.dart';

class UsrList extends Equatable {
  final String lid;
  final String title;
  final String colour;
  final String date;

  const UsrList({this.title, this.colour, this.lid, this.date});

  @override
  List<Object> get props => [title, colour, lid];

  @override
  String toString() => 'Post { lid: $lid }';
}