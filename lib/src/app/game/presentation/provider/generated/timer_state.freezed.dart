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
  bool get showCoolTimer => throw _privateConstructorUsedError;
  Duration get coolTimer => throw _privateConstructorUsedError;
  bool get showSkipTimer => throw _privateConstructorUsedError;
  Duration get skipTimer => throw _privateConstructorUsedError;
  bool get showTurnTimer => throw _privateConstructorUsedError;
  Duration get turnTimer => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TimerStateCopyWith<TimerState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TimerStateCopyWith<$Res> {
  factory $TimerStateCopyWith(
          TimerState value, $Res Function(TimerState) then) =
      _$TimerStateCopyWithImpl<$Res, TimerState>;
  @useResult
  $Res call(
      {bool showCoolTimer,
      Duration coolTimer,
      bool showSkipTimer,
      Duration skipTimer,
      bool showTurnTimer,
      Duration turnTimer});
}

/// @nodoc
class _$TimerStateCopyWithImpl<$Res, $Val extends TimerState>
    implements $TimerStateCopyWith<$Res> {
  _$TimerStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCoolTimer = null,
    Object? coolTimer = null,
    Object? showSkipTimer = null,
    Object? skipTimer = null,
    Object? showTurnTimer = null,
    Object? turnTimer = null,
  }) {
    return _then(_value.copyWith(
      showCoolTimer: null == showCoolTimer
          ? _value.showCoolTimer
          : showCoolTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      coolTimer: null == coolTimer
          ? _value.coolTimer
          : coolTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      showSkipTimer: null == showSkipTimer
          ? _value.showSkipTimer
          : showSkipTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      skipTimer: null == skipTimer
          ? _value.skipTimer
          : skipTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      showTurnTimer: null == showTurnTimer
          ? _value.showTurnTimer
          : showTurnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      turnTimer: null == turnTimer
          ? _value.turnTimer
          : turnTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TimerStateImplCopyWith<$Res>
    implements $TimerStateCopyWith<$Res> {
  factory _$$TimerStateImplCopyWith(
          _$TimerStateImpl value, $Res Function(_$TimerStateImpl) then) =
      __$$TimerStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool showCoolTimer,
      Duration coolTimer,
      bool showSkipTimer,
      Duration skipTimer,
      bool showTurnTimer,
      Duration turnTimer});
}

/// @nodoc
class __$$TimerStateImplCopyWithImpl<$Res>
    extends _$TimerStateCopyWithImpl<$Res, _$TimerStateImpl>
    implements _$$TimerStateImplCopyWith<$Res> {
  __$$TimerStateImplCopyWithImpl(
      _$TimerStateImpl _value, $Res Function(_$TimerStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? showCoolTimer = null,
    Object? coolTimer = null,
    Object? showSkipTimer = null,
    Object? skipTimer = null,
    Object? showTurnTimer = null,
    Object? turnTimer = null,
  }) {
    return _then(_$TimerStateImpl(
      showCoolTimer: null == showCoolTimer
          ? _value.showCoolTimer
          : showCoolTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      coolTimer: null == coolTimer
          ? _value.coolTimer
          : coolTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      showSkipTimer: null == showSkipTimer
          ? _value.showSkipTimer
          : showSkipTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      skipTimer: null == skipTimer
          ? _value.skipTimer
          : skipTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
      showTurnTimer: null == showTurnTimer
          ? _value.showTurnTimer
          : showTurnTimer // ignore: cast_nullable_to_non_nullable
              as bool,
      turnTimer: null == turnTimer
          ? _value.turnTimer
          : turnTimer // ignore: cast_nullable_to_non_nullable
              as Duration,
    ));
  }
}

/// @nodoc

class _$TimerStateImpl implements _TimerState {
  const _$TimerStateImpl(
      {this.showCoolTimer = false,
      this.coolTimer = Duration.zero,
      this.showSkipTimer = false,
      this.skipTimer = Duration.zero,
      this.showTurnTimer = false,
      this.turnTimer = Duration.zero});

  @override
  @JsonKey()
  final bool showCoolTimer;
  @override
  @JsonKey()
  final Duration coolTimer;
  @override
  @JsonKey()
  final bool showSkipTimer;
  @override
  @JsonKey()
  final Duration skipTimer;
  @override
  @JsonKey()
  final bool showTurnTimer;
  @override
  @JsonKey()
  final Duration turnTimer;

  @override
  String toString() {
    return 'TimerState(showCoolTimer: $showCoolTimer, coolTimer: $coolTimer, showSkipTimer: $showSkipTimer, skipTimer: $skipTimer, showTurnTimer: $showTurnTimer, turnTimer: $turnTimer)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TimerStateImpl &&
            (identical(other.showCoolTimer, showCoolTimer) ||
                other.showCoolTimer == showCoolTimer) &&
            (identical(other.coolTimer, coolTimer) ||
                other.coolTimer == coolTimer) &&
            (identical(other.showSkipTimer, showSkipTimer) ||
                other.showSkipTimer == showSkipTimer) &&
            (identical(other.skipTimer, skipTimer) ||
                other.skipTimer == skipTimer) &&
            (identical(other.showTurnTimer, showTurnTimer) ||
                other.showTurnTimer == showTurnTimer) &&
            (identical(other.turnTimer, turnTimer) ||
                other.turnTimer == turnTimer));
  }

  @override
  int get hashCode => Object.hash(runtimeType, showCoolTimer, coolTimer,
      showSkipTimer, skipTimer, showTurnTimer, turnTimer);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      __$$TimerStateImplCopyWithImpl<_$TimerStateImpl>(this, _$identity);
}

abstract class _TimerState implements TimerState {
  const factory _TimerState(
      {final bool showCoolTimer,
      final Duration coolTimer,
      final bool showSkipTimer,
      final Duration skipTimer,
      final bool showTurnTimer,
      final Duration turnTimer}) = _$TimerStateImpl;

  @override
  bool get showCoolTimer;
  @override
  Duration get coolTimer;
  @override
  bool get showSkipTimer;
  @override
  Duration get skipTimer;
  @override
  bool get showTurnTimer;
  @override
  Duration get turnTimer;
  @override
  @JsonKey(ignore: true)
  _$$TimerStateImplCopyWith<_$TimerStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
