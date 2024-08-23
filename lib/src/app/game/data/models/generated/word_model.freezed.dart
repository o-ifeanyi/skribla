// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../word_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WordModel _$WordModelFromJson(Map<String, dynamic> json) {
  return _WordModel.fromJson(json);
}

/// @nodoc
mixin _$WordModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  int get index => throw _privateConstructorUsedError;
  Map<String, String> get loc => throw _privateConstructorUsedError;
  bool get available => throw _privateConstructorUsedError;

  /// Serializes this WordModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WordModelCopyWith<WordModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WordModelCopyWith<$Res> {
  factory $WordModelCopyWith(WordModel value, $Res Function(WordModel) then) =
      _$WordModelCopyWithImpl<$Res, WordModel>;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String text,
      int index,
      Map<String, String> loc,
      bool available});
}

/// @nodoc
class _$WordModelCopyWithImpl<$Res, $Val extends WordModel> implements $WordModelCopyWith<$Res> {
  _$WordModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
    Object? index = null,
    Object? loc = null,
    Object? available = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      loc: null == loc
          ? _value.loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WordModelImplCopyWith<$Res> implements $WordModelCopyWith<$Res> {
  factory _$$WordModelImplCopyWith(_$WordModelImpl value, $Res Function(_$WordModelImpl) then) =
      __$$WordModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      String text,
      int index,
      Map<String, String> loc,
      bool available});
}

/// @nodoc
class __$$WordModelImplCopyWithImpl<$Res> extends _$WordModelCopyWithImpl<$Res, _$WordModelImpl>
    implements _$$WordModelImplCopyWith<$Res> {
  __$$WordModelImplCopyWithImpl(_$WordModelImpl _value, $Res Function(_$WordModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of WordModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? text = null,
    Object? index = null,
    Object? loc = null,
    Object? available = null,
  }) {
    return _then(_$WordModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      index: null == index
          ? _value.index
          : index // ignore: cast_nullable_to_non_nullable
              as int,
      loc: null == loc
          ? _value._loc
          : loc // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      available: null == available
          ? _value.available
          : available // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WordModelImpl extends _WordModel {
  const _$WordModelImpl(
      {required this.id,
      required this.createdAt,
      required this.text,
      this.index = 0,
      final Map<String, String> loc = const {},
      this.available = true})
      : _loc = loc,
        super._();

  factory _$WordModelImpl.fromJson(Map<String, dynamic> json) => _$$WordModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final String text;
  @override
  @JsonKey()
  final int index;
  final Map<String, String> _loc;
  @override
  @JsonKey()
  Map<String, String> get loc {
    if (_loc is EqualUnmodifiableMapView) return _loc;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_loc);
  }

  @override
  @JsonKey()
  final bool available;

  @override
  String toString() {
    return 'WordModel(id: $id, createdAt: $createdAt, text: $text, index: $index, loc: $loc, available: $available)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WordModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.index, index) || other.index == index) &&
            const DeepCollectionEquality().equals(other._loc, _loc) &&
            (identical(other.available, available) || other.available == available));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, createdAt, text, index,
      const DeepCollectionEquality().hash(_loc), available);

  /// Create a copy of WordModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WordModelImplCopyWith<_$WordModelImpl> get copyWith =>
      __$$WordModelImplCopyWithImpl<_$WordModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WordModelImplToJson(
      this,
    );
  }
}

abstract class _WordModel extends WordModel {
  const factory _WordModel(
      {required final String id,
      required final DateTime createdAt,
      required final String text,
      final int index,
      final Map<String, String> loc,
      final bool available}) = _$WordModelImpl;
  const _WordModel._() : super._();

  factory _WordModel.fromJson(Map<String, dynamic> json) = _$WordModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  String get text;
  @override
  int get index;
  @override
  Map<String, String> get loc;
  @override
  bool get available;

  /// Create a copy of WordModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WordModelImplCopyWith<_$WordModelImpl> get copyWith => throw _privateConstructorUsedError;
}
