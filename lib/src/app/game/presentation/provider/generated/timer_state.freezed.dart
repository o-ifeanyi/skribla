// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../timer_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TimerState {
  TimerType get timerType => throw _privateConstructorUsedError;
  Duration get coolDuration => throw _privateConstructorUsedError;
  Duration get skipDuration => throw _privateConstructorUsedError;
  Duration get turnDuration => throw _privateConstructorUsedError;
  Duration get completeDuration => throw _privateConstructorUsedError;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $TimerStateCopyWith<TimerState> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(TimerState value, $Res Function(TimerState) then) =
      _$TimerStateCopyWithImpl<$Res, TimerState>;
  @useResult
  $Res call(
      {TimerType timerType,
      Duration coolDuration,
      Duration skipDuration,
      Duration turnDuration,
      Duration completeDuration});
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res, $Val extends TimerState> implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerType = null,
    Object? coolDuration = null,
    Object? skipDuration = null,
    Object? turnDuration = null,
    Object? completeDuration = null,
  }) {
    return _then(_value.copyWith(
      timerType: null == timerType
          ? _value.timerType
          : timerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      coolDuration: null == coolDuration
          ? _value.coolDuration
          : coolDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      skipDuration: null == skipDuration
          ? _value.skipDuration
          : skipDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      turnDuration: null == turnDuration
          ? _value.turnDuration
          : turnDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      completeDuration: null == completeDuration
          ? _value.completeDuration
          : completeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerStateImplCopyWith<$Res> implements $TimerStateCopyWith<$Res> {
  factory _$$TimerStateImplCopyWith(_$TimerStateImpl value, $Res Function(_$TimerStateImpl) then) =
      __$$TimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {TimerType timerType,
      Duration coolDuration,
      Duration skipDuration,
      Duration turnDuration,
      Duration completeDuration});
}

/// @nodoc
class __$$TimerStateImplCopyWithImpl<$Res> extends _$TimerStateCopyWithImpl<$Res, _$TimerStateImpl>
    implements _$$TimerStateImplCopyWith<$Res> {
  __$$TimerStateImplCopyWithImpl(_$TimerStateImpl _value, $Res Function(_$TimerStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? timerType = null,
    Object? coolDuration = null,
    Object? skipDuration = null,
    Object? turnDuration = null,
    Object? completeDuration = null,
  }) {
    return _then(_$TimerStateImpl(
      timerType: null == timerType
          ? _value.timerType
          : timerType // ignore: cast_nullable_to_non_nullable
              as TimerType,
      coolDuration: null == coolDuration
          ? _value.coolDuration
          : coolDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      skipDuration: null == skipDuration
          ? _value.skipDuration
          : skipDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      turnDuration: null == turnDuration
          ? _value.turnDuration
          : turnDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
      completeDuration: null == completeDuration
          ? _value.completeDuration
          : completeDuration // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$TimerStateImpl extends _TimerState {
  const _$TimerStateImpl(
      {this.timerType = TimerType.idle,
      this.coolDuration = Duration.zero,
      this.skipDuration = Duration.zero,
      this.turnDuration = Duration.zero,
      this.completeDuration = Duration.zero})
      : super._();

  @override
  @JsonKey()
  final TimerType timerType;
  @override
  @JsonKey()
  final Duration coolDuration;
  @override
  @JsonKey()
  final Duration skipDuration;
  @override
  @JsonKey()
  final Duration turnDuration;
  @override
  @JsonKey()
  final Duration completeDuration;

  @override
  String toString() {
    return 'TimerState(timerType: $timerType, coolDuration: $coolDuration, skipDuration: $skipDuration, turnDuration: $turnDuration, completeDuration: $completeDuration)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateImpl &&
            (identical(other.timerType, timerType) || other.timerType == timerType) &&
            (identical(other.coolDuration, coolDuration) || other.coolDuration == coolDuration) &&
            (identical(other.skipDuration, skipDuration) || other.skipDuration == skipDuration) &&
            (identical(other.turnDuration, turnDuration) || other.turnDuration == turnDuration) &&
            (identical(other.completeDuration, completeDuration) ||
                other.completeDuration == completeDuration));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, timerType, coolDuration, skipDuration, turnDuration, completeDuration);

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      __$$TimerStateImplCopyWithImpl<_$TimerStateImpl>(this, _$identity);
}

abstract class _TimerState extends TimerState {
  const factory _TimerState(
      {final TimerType timerType,
      final Duration coolDuration,
      final Duration skipDuration,
      final Duration turnDuration,
      final Duration completeDuration}) = _$TimerStateImpl;
  const _TimerState._() : super._();

  @override
  TimerType get timerType;
  @override
  Duration get coolDuration;
  @override
  Duration get skipDuration;
  @override
  Duration get turnDuration;
  @override
  Duration get completeDuration;

  /// Create a copy of TimerState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith => throw _privateConstructorUsedError;
}
