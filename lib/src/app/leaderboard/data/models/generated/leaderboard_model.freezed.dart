// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../leaderboard_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

LeaderboardModel _$LeaderboardModelFromJson(Map<String, dynamic> json) {
  return _LeaderboardModel.fromJson(json);
}

/// @nodoc
mixin _$LeaderboardModel {
  String get uid => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaderboardModelCopyWith<LeaderboardModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardModelCopyWith<$Res> {
  factory $LeaderboardModelCopyWith(
          LeaderboardModel value, $Res Function(LeaderboardModel) then) =
      _$LeaderboardModelCopyWithImpl<$Res, LeaderboardModel>;
  @useResult
  $Res call(
      {String uid,
      DateTime updatedAt,
      DateTime createdAt,
      String name,
      int points});
}

/// @nodoc
class _$LeaderboardModelCopyWithImpl<$Res, $Val extends LeaderboardModel>
    implements $LeaderboardModelCopyWith<$Res> {
  _$LeaderboardModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? name = null,
    Object? points = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardModelImplCopyWith<$Res>
    implements $LeaderboardModelCopyWith<$Res> {
  factory _$$LeaderboardModelImplCopyWith(_$LeaderboardModelImpl value,
          $Res Function(_$LeaderboardModelImpl) then) =
      __$$LeaderboardModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      DateTime updatedAt,
      DateTime createdAt,
      String name,
      int points});
}

/// @nodoc
class __$$LeaderboardModelImplCopyWithImpl<$Res>
    extends _$LeaderboardModelCopyWithImpl<$Res, _$LeaderboardModelImpl>
    implements _$$LeaderboardModelImplCopyWith<$Res> {
  __$$LeaderboardModelImplCopyWithImpl(_$LeaderboardModelImpl _value,
      $Res Function(_$LeaderboardModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? updatedAt = null,
    Object? createdAt = null,
    Object? name = null,
    Object? points = null,
  }) {
    return _then(_$LeaderboardModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$LeaderboardModelImpl implements _LeaderboardModel {
  const _$LeaderboardModelImpl(
      {required this.uid,
      required this.updatedAt,
      required this.createdAt,
      this.name = '',
      this.points = 0});

  factory _$LeaderboardModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$LeaderboardModelImplFromJson(json);

  @override
  final String uid;
  @override
  final DateTime updatedAt;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final int points;

  @override
  String toString() {
    return 'LeaderboardModel(uid: $uid, updatedAt: $updatedAt, createdAt: $createdAt, name: $name, points: $points)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.points, points) || other.points == points));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, uid, updatedAt, createdAt, name, points);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardModelImplCopyWith<_$LeaderboardModelImpl> get copyWith =>
      __$$LeaderboardModelImplCopyWithImpl<_$LeaderboardModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$LeaderboardModelImplToJson(
      this,
    );
  }
}

abstract class _LeaderboardModel implements LeaderboardModel {
  const factory _LeaderboardModel(
      {required final String uid,
      required final DateTime updatedAt,
      required final DateTime createdAt,
      final String name,
      final int points}) = _$LeaderboardModelImpl;

  factory _LeaderboardModel.fromJson(Map<String, dynamic> json) =
      _$LeaderboardModelImpl.fromJson;

  @override
  String get uid;
  @override
  DateTime get updatedAt;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  int get points;
  @override
  @JsonKey(ignore: true)
  _$$LeaderboardModelImplCopyWith<_$LeaderboardModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
