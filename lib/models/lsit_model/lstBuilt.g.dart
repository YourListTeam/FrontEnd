// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lstBuilt.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<BuiltMyList> _$builtMyListSerializer = new _$BuiltMyListSerializer();

class _$BuiltMyListSerializer implements StructuredSerializer<BuiltMyList> {
  @override
  final Iterable<Type> types = const [BuiltMyList, _$BuiltMyList];
  @override
  final String wireName = 'BuiltMyList';

  @override
  Iterable<Object> serialize(Serializers serializers, BuiltMyList object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'listname',
      serializers.serialize(object.listname,
          specifiedType: const FullType(String)),
      'colour',
      serializers.serialize(object.colour,
          specifiedType: const FullType(String)),
    ];
    if (object.lid != null) {
      result
        ..add('lid')
        ..add(serializers.serialize(object.lid,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  BuiltMyList deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new BuiltMyListBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'lid':
          result.lid = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'listname':
          result.listname = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'colour':
          result.colour = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$BuiltMyList extends BuiltMyList {
  @override
  final String lid;
  @override
  final String listname;
  @override
  final String colour;

  factory _$BuiltMyList([void Function(BuiltMyListBuilder) updates]) =>
      (new BuiltMyListBuilder()..update(updates)).build();

  _$BuiltMyList._({this.lid, this.listname, this.colour}) : super._() {
    if (listname == null) {
      throw new BuiltValueNullFieldError('BuiltMyList', 'listname');
    }
    if (colour == null) {
      throw new BuiltValueNullFieldError('BuiltMyList', 'colour');
    }
  }

  @override
  BuiltMyList rebuild(void Function(BuiltMyListBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  BuiltMyListBuilder toBuilder() => new BuiltMyListBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is BuiltMyList &&
        lid == other.lid &&
        listname == other.listname &&
        colour == other.colour;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, lid.hashCode), listname.hashCode), colour.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('BuiltMyList')
          ..add('lid', lid)
          ..add('listname', listname)
          ..add('colour', colour))
        .toString();
  }
}

class BuiltMyListBuilder implements Builder<BuiltMyList, BuiltMyListBuilder> {
  _$BuiltMyList _$v;

  String _lid;
  String get lid => _$this._lid;
  set lid(String lid) => _$this._lid = lid;

  String _listname;
  String get listname => _$this._listname;
  set listname(String listname) => _$this._listname = listname;

  String _colour;
  String get colour => _$this._colour;
  set colour(String colour) => _$this._colour = colour;

  BuiltMyListBuilder();

  BuiltMyListBuilder get _$this {
    if (_$v != null) {
      _lid = _$v.lid;
      _listname = _$v.listname;
      _colour = _$v.colour;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(BuiltMyList other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$BuiltMyList;
  }

  @override
  void update(void Function(BuiltMyListBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$BuiltMyList build() {
    final _$result = _$v ??
        new _$BuiltMyList._(lid: lid, listname: listname, colour: colour);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
