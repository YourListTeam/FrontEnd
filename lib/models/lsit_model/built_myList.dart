
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:equatable/equatable.dart';


class UsrList extends Equatable {
  final String lid;

  final String listname;
  final String colour;
//  final String modified;

  UsrList({this.lid, this.listname, this.colour});

  @override
  List<Object> get props => [lid, listname, colour];

  @override
  String toString() => 'Post { lid: $lid }';
}