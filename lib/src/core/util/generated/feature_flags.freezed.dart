// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../feature_flags.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

FeatureFlags _$FeatureFlagsFromJson(Map<String, dynamic> json) {
  return _FeatureFlags.fromJson(json);
}

/// @nodoc
mixin _$FeatureFlags {
  int get majorVersion => throw _privateConstructorUsedError;
  int get minorVersion => throw _privateConstructorUsedError;
  bool get webDown => throw _privateConstructorUsedError;
  bool get iosDown => throw _privateConstructorUsedError;
  bool get androidDown => throw _privateConstructorUsedError;
  bool get macDown => throw _privateConstructorUsedError;
  int get drawDelayMilliseconds => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FeatureFlagsCopyWith<FeatureFlags> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FeatureFlagsCopyWith<$Res> {
  factory $FeatureFlagsCopyWith(FeatureFlags value, $Res Function(FeatureFlags) then) =
      _$FeatureFlagsCopyWithImpl<$Res, FeatureFlags>;
  @useResult
  $Res call(
      {int majorVersion,
      int minorVersion,
      bool webDown,
      bool iosDown,
      bool androidDown,
      bool macDown,
      int drawDelayMilliseconds});
}

/// @nodoc
class _$FeatureFlagsCopyWithImpl<$Res, $Val extends FeatureFlags>
    implements $FeatureFlagsCopyWith<$Res> {
  _$FeatureFlagsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? majorVersion = null,
    Object? minorVersion = null,
    Object? webDown = null,
    Object? iosDown = null,
    Object? androidDown = null,
    Object? macDown = null,
    Object? drawDelayMilliseconds = null,
  }) {
    return _then(_value.copyWith(
      majorVersion: null == majorVersion
          ? _value.majorVersion
          : majorVersion // ignore: cast_nullable_to_non_nullable
              as int,
      minorVersion: null == minorVersion
          ? _value.minorVersion
          : minorVersion // ignore: cast_nullable_to_non_nullable
              as int,
      webDown: null == webDown
          ? _value.webDown
          : webDown // ignore: cast_nullable_to_non_nullable
              as bool,
      iosDown: null == iosDown
          ? _value.iosDown
          : iosDown // ignore: cast_nullable_to_non_nullable
              as bool,
      androidDown: null == androidDown
          ? _value.androidDown
          : androidDown // ignore: cast_nullable_to_non_nullable
              as bool,
      macDown: null == macDown
          ? _value.macDown
          : macDown // ignore: cast_nullable_to_non_nullable
              as bool,
      drawDelayMilliseconds: null == drawDelayMilliseconds
          ? _value.drawDelayMilliseconds
          : drawDelayMilliseconds // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FeatureFlagsImplCopyWith<$Res> implements $FeatureFlagsCopyWith<$Res> {
  factory _$$FeatureFlagsImplCopyWith(
          _$FeatureFlagsImpl value, $Res Function(_$FeatureFlagsImpl) then) =
      __$$FeatureFlagsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int majorVersion,
      int minorVersion,
      bool webDown,
      bool iosDown,
      bool androidDown,
      bool macDown,
      int drawDelayMilliseconds});
}

/// @nodoc
class __$$FeatureFlagsImplCopyWithImpl<$Res>
    extends _$FeatureFlagsCopyWithImpl<$Res, _$FeatureFlagsImpl>
    implements _$$FeatureFlagsImplCopyWith<$Res> {
  __$$FeatureFlagsImplCopyWithImpl(
      _$FeatureFlagsImpl _value, $Res Function(_$FeatureFlagsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? majorVersion = null,
    Object? minorVersion = null,
    Object? webDown = null,
    Object? iosDown = null,
    Object? androidDown = null,
    Object? macDown = null,
    Object? drawDelayMilliseconds = null,
  }) {
    return _then(_$FeatureFlagsImpl(
      majorVersion: null == majorVersion
          ? _value.majorVersion
          : majorVersion // ignore: cast_nullable_to_non_nullable
              as int,
      minorVersion: null == minorVersion
          ? _value.minorVersion
          : minorVersion // ignore: cast_nullable_to_non_nullable
              as int,
      webDown: null == webDown
          ? _value.webDown
          : webDown // ignore: cast_nullable_to_non_nullable
              as bool,
      iosDown: null == iosDown
          ? _value.iosDown
          : iosDown // ignore: cast_nullable_to_non_nullable
              as bool,
      androidDown: null == androidDown
          ? _value.androidDown
          : androidDown // ignore: cast_nullable_to_non_nullable
              as bool,
      macDown: null == macDown
          ? _value.macDown
          : macDown // ignore: cast_nullable_to_non_nullable
              as bool,
      drawDelayMilliseconds: null == drawDelayMilliseconds
          ? _value.drawDelayMilliseconds
          : drawDelayMilliseconds // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$FeatureFlagsImpl extends _FeatureFlags with DiagnosticableTreeMixin {
  const _$FeatureFlagsImpl(
      {this.majorVersion = 1,
      this.minorVersion = 0,
      this.webDown = false,
      this.iosDown = false,
      this.androidDown = false,
      this.macDown = false,
      this.drawDelayMilliseconds = 100})
      : super._();

  factory _$FeatureFlagsImpl.fromJson(Map<String, dynamic> json) =>
      _$$FeatureFlagsImplFromJson(json);

  @override
  @JsonKey()
  final int majorVersion;
  @override
  @JsonKey()
  final int minorVersion;
  @override
  @JsonKey()
  final bool webDown;
  @override
  @JsonKey()
  final bool iosDown;
  @override
  @JsonKey()
  final bool androidDown;
  @override
  @JsonKey()
  final bool macDown;
  @override
  @JsonKey()
  final int drawDelayMilliseconds;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'FeatureFlags(majorVersion: $majorVersion, minorVersion: $minorVersion, webDown: $webDown, iosDown: $iosDown, androidDown: $androidDown, macDown: $macDown, drawDelayMilliseconds: $drawDelayMilliseconds)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'FeatureFlags'))
      ..add(DiagnosticsProperty('majorVersion', majorVersion))
      ..add(DiagnosticsProperty('minorVersion', minorVersion))
      ..add(DiagnosticsProperty('webDown', webDown))
      ..add(DiagnosticsProperty('iosDown', iosDown))
      ..add(DiagnosticsProperty('androidDown', androidDown))
      ..add(DiagnosticsProperty('macDown', macDown))
      ..add(DiagnosticsProperty('drawDelayMilliseconds', drawDelayMilliseconds));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FeatureFlagsImpl &&
            (identical(other.majorVersion, majorVersion) || other.majorVersion == majorVersion) &&
            (identical(other.minorVersion, minorVersion) || other.minorVersion == minorVersion) &&
            (identical(other.webDown, webDown) || other.webDown == webDown) &&
            (identical(other.iosDown, iosDown) || other.iosDown == iosDown) &&
            (identical(other.androidDown, androidDown) || other.androidDown == androidDown) &&
            (identical(other.macDown, macDown) || other.macDown == macDown) &&
            (identical(other.drawDelayMilliseconds, drawDelayMilliseconds) ||
                other.drawDelayMilliseconds == drawDelayMilliseconds));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, majorVersion, minorVersion, webDown, iosDown,
      androidDown, macDown, drawDelayMilliseconds);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FeatureFlagsImplCopyWith<_$FeatureFlagsImpl> get copyWith =>
      __$$FeatureFlagsImplCopyWithImpl<_$FeatureFlagsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$FeatureFlagsImplToJson(
      this,
    );
  }
}

abstract class _FeatureFlags extends FeatureFlags {
  const factory _FeatureFlags(
      {final int majorVersion,
      final int minorVersion,
      final bool webDown,
      final bool iosDown,
      final bool androidDown,
      final bool macDown,
      final int drawDelayMilliseconds}) = _$FeatureFlagsImpl;
  const _FeatureFlags._() : super._();

  factory _FeatureFlags.fromJson(Map<String, dynamic> json) = _$FeatureFlagsImpl.fromJson;

  @override
  int get majorVersion;
  @override
  int get minorVersion;
  @override
  bool get webDown;
  @override
  bool get iosDown;
  @override
  bool get androidDown;
  @override
  bool get macDown;
  @override
  int get drawDelayMilliseconds;
  @override
  @JsonKey(ignore: true)
  _$$FeatureFlagsImplCopyWith<_$FeatureFlagsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
