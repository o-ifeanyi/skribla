// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../leaderboard_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$LeaderboardState {
  LeaderboardStatus get status => throw _privateConstructorUsedError;
  LeaderboardType get type => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LeaderboardStateCopyWith<LeaderboardState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardStateCopyWith<$Res> {
  factory $LeaderboardStateCopyWith(LeaderboardState value, $Res Function(LeaderboardState) then) =
      _$LeaderboardStateCopyWithImpl<$Res, LeaderboardState>;
  @useResult
  $Res call({LeaderboardStatus status, LeaderboardType type});
}

/// @nodoc
class _$LeaderboardStateCopyWithImpl<$Res, $Val extends LeaderboardState>
    implements $LeaderboardStateCopyWith<$Res> {
  _$LeaderboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LeaderboardStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LeaderboardType,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$LeaderboardStateImplCopyWith<$Res> implements $LeaderboardStateCopyWith<$Res> {
  factory _$$LeaderboardStateImplCopyWith(
          _$LeaderboardStateImpl value, $Res Function(_$LeaderboardStateImpl) then) =
      __$$LeaderboardStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({LeaderboardStatus status, LeaderboardType type});
}

/// @nodoc
class __$$LeaderboardStateImplCopyWithImpl<$Res>
    extends _$LeaderboardStateCopyWithImpl<$Res, _$LeaderboardStateImpl>
    implements _$$LeaderboardStateImplCopyWith<$Res> {
  __$$LeaderboardStateImplCopyWithImpl(
      _$LeaderboardStateImpl _value, $Res Function(_$LeaderboardStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
  }) {
    return _then(_$LeaderboardStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as LeaderboardStatus,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as LeaderboardType,
    ));
  }
}

/// @nodoc

class _$LeaderboardStateImpl implements _LeaderboardState {
  const _$LeaderboardStateImpl(
      {this.status = LeaderboardStatus.idle, this.type = LeaderboardType.monthly});

  @override
  @JsonKey()
  final LeaderboardStatus status;
  @override
  @JsonKey()
  final LeaderboardType type;

  @override
  String toString() {
    return 'LeaderboardState(status: $status, type: $type)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status, type);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardStateImplCopyWith<_$LeaderboardStateImpl> get copyWith =>
      __$$LeaderboardStateImplCopyWithImpl<_$LeaderboardStateImpl>(this, _$identity);
}

abstract class _LeaderboardState implements LeaderboardState {
  const factory _LeaderboardState({final LeaderboardStatus status, final LeaderboardType type}) =
      _$LeaderboardStateImpl;

  @override
  LeaderboardStatus get status;
  @override
  LeaderboardType get type;
  @override
  @JsonKey(ignore: true)
  _$$LeaderboardStateImplCopyWith<_$LeaderboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
