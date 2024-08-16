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
  List<LeaderboardModel> get topThree => throw _privateConstructorUsedError;

  /// Create a copy of LeaderboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $LeaderboardStateCopyWith<LeaderboardState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaderboardStateCopyWith<$Res> {
  factory $LeaderboardStateCopyWith(LeaderboardState value, $Res Function(LeaderboardState) then) =
      _$LeaderboardStateCopyWithImpl<$Res, LeaderboardState>;
  @useResult
  $Res call({LeaderboardStatus status, LeaderboardType type, List<LeaderboardModel> topThree});
}

/// @nodoc
class _$LeaderboardStateCopyWithImpl<$Res, $Val extends LeaderboardState>
    implements $LeaderboardStateCopyWith<$Res> {
  _$LeaderboardStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of LeaderboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
    Object? topThree = null,
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
      topThree: null == topThree
          ? _value.topThree
          : topThree // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardModel>,
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
  $Res call({LeaderboardStatus status, LeaderboardType type, List<LeaderboardModel> topThree});
}

/// @nodoc
class __$$LeaderboardStateImplCopyWithImpl<$Res>
    extends _$LeaderboardStateCopyWithImpl<$Res, _$LeaderboardStateImpl>
    implements _$$LeaderboardStateImplCopyWith<$Res> {
  __$$LeaderboardStateImplCopyWithImpl(
      _$LeaderboardStateImpl _value, $Res Function(_$LeaderboardStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of LeaderboardState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
    Object? type = null,
    Object? topThree = null,
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
      topThree: null == topThree
          ? _value._topThree
          : topThree // ignore: cast_nullable_to_non_nullable
              as List<LeaderboardModel>,
    ));
  }
}

/// @nodoc

class _$LeaderboardStateImpl implements _LeaderboardState {
  const _$LeaderboardStateImpl(
      {this.status = LeaderboardStatus.idle,
      this.type = LeaderboardType.monthly,
      final List<LeaderboardModel> topThree = const []})
      : _topThree = topThree;

  @override
  @JsonKey()
  final LeaderboardStatus status;
  @override
  @JsonKey()
  final LeaderboardType type;
  final List<LeaderboardModel> _topThree;
  @override
  @JsonKey()
  List<LeaderboardModel> get topThree {
    if (_topThree is EqualUnmodifiableListView) return _topThree;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_topThree);
  }

  @override
  String toString() {
    return 'LeaderboardState(status: $status, type: $type, topThree: $topThree)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LeaderboardStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._topThree, _topThree));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, status, type, const DeepCollectionEquality().hash(_topThree));

  /// Create a copy of LeaderboardState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$LeaderboardStateImplCopyWith<_$LeaderboardStateImpl> get copyWith =>
      __$$LeaderboardStateImplCopyWithImpl<_$LeaderboardStateImpl>(this, _$identity);
}

abstract class _LeaderboardState implements LeaderboardState {
  const factory _LeaderboardState(
      {final LeaderboardStatus status,
      final LeaderboardType type,
      final List<LeaderboardModel> topThree}) = _$LeaderboardStateImpl;

  @override
  LeaderboardStatus get status;
  @override
  LeaderboardType get type;
  @override
  List<LeaderboardModel> get topThree;

  /// Create a copy of LeaderboardState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$LeaderboardStateImplCopyWith<_$LeaderboardStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
