
import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:equatable/equatable.dart';

class UsrItem extends Equatable {
  final String iid;
  final String uuid;
  final String lid;
  final String name;
  final bool completed;
  final String modified;



  const UsrItem({this.iid, this.uuid, this.lid, this.name, this.completed, this.modified});

  @override
  List<Object> get props => [iid, uuid, lid, name, completed, modified];

  @override
  String toString() => 'Item { iid: $iid }';
}