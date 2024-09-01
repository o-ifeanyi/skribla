// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserModel _$UserModelFromJson(Map<String, dynamic> json) {
  return _UserModel.fromJson(json);
}

/// @nodoc
mixin _$UserModel {
  String get uid => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  int get reportCount => throw _privateConstructorUsedError;
  List<String> get blockedUsers => throw _privateConstructorUsedError;
  int? get lastWordIndex => throw _privateConstructorUsedError;
  UserStatus get status => throw _privateConstructorUsedError;

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserModelCopyWith<UserModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) then) =
      _$UserModelCopyWithImpl<$Res, UserModel>;
  @useResult
  $Res call(
      {String uid,
      DateTime createdAt,
      String name,
      String email,
      int reportCount,
      List<String> blockedUsers,
      int? lastWordIndex,
      UserStatus status});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res, $Val extends UserModel> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
    Object? name = null,
    Object? email = null,
    Object? reportCount = null,
    Object? blockedUsers = null,
    Object? lastWordIndex = freezed,
    Object? status = null,
  }) {
    return _then(_value.copyWith(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      reportCount: null == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int,
      blockedUsers: null == blockedUsers
          ? _value.blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastWordIndex: freezed == lastWordIndex
          ? _value.lastWordIndex
          : lastWordIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserModelImplCopyWith<$Res> implements $UserModelCopyWith<$Res> {
  factory _$$UserModelImplCopyWith(_$UserModelImpl value, $Res Function(_$UserModelImpl) then) =
      __$$UserModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String uid,
      DateTime createdAt,
      String name,
      String email,
      int reportCount,
      List<String> blockedUsers,
      int? lastWordIndex,
      UserStatus status});
}

/// @nodoc
class __$$UserModelImplCopyWithImpl<$Res> extends _$UserModelCopyWithImpl<$Res, _$UserModelImpl>
    implements _$$UserModelImplCopyWith<$Res> {
  __$$UserModelImplCopyWithImpl(_$UserModelImpl _value, $Res Function(_$UserModelImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? uid = null,
    Object? createdAt = null,
    Object? name = null,
    Object? email = null,
    Object? reportCount = null,
    Object? blockedUsers = null,
    Object? lastWordIndex = freezed,
    Object? status = null,
  }) {
    return _then(_$UserModelImpl(
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      reportCount: null == reportCount
          ? _value.reportCount
          : reportCount // ignore: cast_nullable_to_non_nullable
              as int,
      blockedUsers: null == blockedUsers
          ? _value._blockedUsers
          : blockedUsers // ignore: cast_nullable_to_non_nullable
              as List<String>,
      lastWordIndex: freezed == lastWordIndex
          ? _value.lastWordIndex
          : lastWordIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as UserStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserModelImpl extends _UserModel {
  const _$UserModelImpl(
      {required this.uid,
      required this.createdAt,
      this.name = '',
      this.email = '',
      this.reportCount = 0,
      final List<String> blockedUsers = const [],
      this.lastWordIndex = null,
      this.status = UserStatus.anonymous})
      : _blockedUsers = blockedUsers,
        super._();

  factory _$UserModelImpl.fromJson(Map<String, dynamic> json) => _$$UserModelImplFromJson(json);

  @override
  final String uid;
  @override
  final DateTime createdAt;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String email;
  @override
  @JsonKey()
  final int reportCount;
  final List<String> _blockedUsers;
  @override
  @JsonKey()
  List<String> get blockedUsers {
    if (_blockedUsers is EqualUnmodifiableListView) return _blockedUsers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_blockedUsers);
  }

  @override
  @JsonKey()
  final int? lastWordIndex;
  @override
  @JsonKey()
  final UserStatus status;

  @override
  String toString() {
    return 'UserModel(uid: $uid, createdAt: $createdAt, name: $name, email: $email, reportCount: $reportCount, blockedUsers: $blockedUsers, lastWordIndex: $lastWordIndex, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserModelImpl &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.reportCount, reportCount) || other.reportCount == reportCount) &&
            const DeepCollectionEquality().equals(other._blockedUsers, _blockedUsers) &&
            (identical(other.lastWordIndex, lastWordIndex) ||
                other.lastWordIndex == lastWordIndex) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, uid, createdAt, name, email, reportCount,
      const DeepCollectionEquality().hash(_blockedUsers), lastWordIndex, status);

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith =>
      __$$UserModelImplCopyWithImpl<_$UserModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserModelImplToJson(
      this,
    );
  }
}

abstract class _UserModel extends UserModel {
  const factory _UserModel(
      {required final String uid,
      required final DateTime createdAt,
      final String name,
      final String email,
      final int reportCount,
      final List<String> blockedUsers,
      final int? lastWordIndex,
      final UserStatus status}) = _$UserModelImpl;
  const _UserModel._() : super._();

  factory _UserModel.fromJson(Map<String, dynamic> json) = _$UserModelImpl.fromJson;

  @override
  String get uid;
  @override
  DateTime get createdAt;
  @override
  String get name;
  @override
  String get email;
  @override
  int get reportCount;
  @override
  List<String> get blockedUsers;
  @override
  int? get lastWordIndex;
  @override
  UserStatus get status;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserModelImplCopyWith<_$UserModelImpl> get copyWith => throw _privateConstructorUsedError;
}
