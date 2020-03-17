import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'lstBuilt.g.dart';

abstract class BuiltMyList implements Built<BuiltMyList, BuiltMyListBuilder> {
  @nullable
  String get LID;
  @nullable
  String get UUID;
  @nullable
  String get lid;
  @nullable
  String get uuid;

  String get listname;
  String get colour;

  BuiltMyList._();

  factory BuiltMyList([updates(BuiltMyListBuilder b)]) = _$BuiltMyList;

  static Serializer<BuiltMyList> get serializer => _$builtMyListSerializer;
}
