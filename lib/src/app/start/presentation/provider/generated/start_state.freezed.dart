// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../start_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$StartState {
  StartStatus get status => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $StartStateCopyWith<StartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StartStateCopyWith<$Res> {
  factory $StartStateCopyWith(
          StartState value, $Res Function(StartState) then) =
      _$StartStateCopyWithImpl<$Res, StartState>;
  @useResult
  $Res call({StartStatus status});
}

/// @nodoc
class _$StartStateCopyWithImpl<$Res, $Val extends StartState>
    implements $StartStateCopyWith<$Res> {
  _$StartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StartStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StartStateImplCopyWith<$Res>
    implements $StartStateCopyWith<$Res> {
  factory _$$StartStateImplCopyWith(
          _$StartStateImpl value, $Res Function(_$StartStateImpl) then) =
      __$$StartStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({StartStatus status});
}

/// @nodoc
class __$$StartStateImplCopyWithImpl<$Res>
    extends _$StartStateCopyWithImpl<$Res, _$StartStateImpl>
    implements _$$StartStateImplCopyWith<$Res> {
  __$$StartStateImplCopyWithImpl(
      _$StartStateImpl _value, $Res Function(_$StartStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = null,
  }) {
    return _then(_$StartStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as StartStatus,
    ));
  }
}

/// @nodoc

class _$StartStateImpl implements _StartState {
  const _$StartStateImpl({this.status = StartStatus.idle});

  @override
  @JsonKey()
  final StartStatus status;

  @override
  String toString() {
    return 'StartState(status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StartStateImpl &&
            (identical(other.status, status) || other.status == status));
  }

  @override
  int get hashCode => Object.hash(runtimeType, status);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StartStateImplCopyWith<_$StartStateImpl> get copyWith =>
      __$$StartStateImplCopyWithImpl<_$StartStateImpl>(this, _$identity);
}

abstract class _StartState implements StartState {
  const factory _StartState({final StartStatus status}) = _$StartStateImpl;

  @override
  StartStatus get status;
  @override
  @JsonKey(ignore: true)
  _$$StartStateImplCopyWith<_$StartStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
