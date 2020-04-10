
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:equatable/equatable.dart';


/// This is an object which is used to store information about the list
/// all of this information is obtained from node server
/// This class is mainly used to make it easier to display information
/// in home_list.dart
class UsrList extends Equatable {
  final String lid;
  final String title;
  final String colour;
  final String date;
  final String hex;
  String location;

  UsrList({this.title, this.colour, this.lid, this.date, this.hex});

  @override
  List<Object> get props => [title, colour, lid];

  @override
  String toString() => 'Post { lid: $lid }';
}