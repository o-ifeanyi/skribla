// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of '../game_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameModel _$GameModelFromJson(Map<String, dynamic> json) {
  return _GameModel.fromJson(json);
}

/// @nodoc
mixin _$GameModel {
  String get id => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  PlayerModel get currentPlayer => throw _privateConstructorUsedError;
  WordModel get currentWord => throw _privateConstructorUsedError;
  Status get status => throw _privateConstructorUsedError;
  List<String> get uids => throw _privateConstructorUsedError;
  List<String> get correctGuess => throw _privateConstructorUsedError;
  List<PlayerModel> get players => throw _privateConstructorUsedError;
  List<String> get online => throw _privateConstructorUsedError;
  List<LineModel> get currentArt => throw _privateConstructorUsedError;
  int get numOfPlayers => throw _privateConstructorUsedError;
  int get numOfArts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GameModelCopyWith<GameModel> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameModelCopyWith<$Res> {
  factory $GameModelCopyWith(GameModel value, $Res Function(GameModel) then) =
      _$GameModelCopyWithImpl<$Res, GameModel>;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      PlayerModel currentPlayer,
      WordModel currentWord,
      Status status,
      List<String> uids,
      List<String> correctGuess,
      List<PlayerModel> players,
      List<String> online,
      List<LineModel> currentArt,
      int numOfPlayers,
      int numOfArts});

  $PlayerModelCopyWith<$Res> get currentPlayer;
  $WordModelCopyWith<$Res> get currentWord;
}

/// @nodoc
class _$GameModelCopyWithImpl<$Res, $Val extends GameModel> implements $GameModelCopyWith<$Res> {
  _$GameModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? currentPlayer = null,
    Object? currentWord = null,
    Object? status = null,
    Object? uids = null,
    Object? correctGuess = null,
    Object? players = null,
    Object? online = null,
    Object? currentArt = null,
    Object? numOfPlayers = null,
    Object? numOfArts = null,
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
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
      currentWord: null == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as WordModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      uids: null == uids
          ? _value.uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctGuess: null == correctGuess
          ? _value.correctGuess
          : correctGuess // ignore: cast_nullable_to_non_nullable
              as List<String>,
      players: null == players
          ? _value.players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      online: null == online
          ? _value.online
          : online // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentArt: null == currentArt
          ? _value.currentArt
          : currentArt // ignore: cast_nullable_to_non_nullable
              as List<LineModel>,
      numOfPlayers: null == numOfPlayers
          ? _value.numOfPlayers
          : numOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      numOfArts: null == numOfArts
          ? _value.numOfArts
          : numOfArts // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PlayerModelCopyWith<$Res> get currentPlayer {
    return $PlayerModelCopyWith<$Res>(_value.currentPlayer, (value) {
      return _then(_value.copyWith(currentPlayer: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $WordModelCopyWith<$Res> get currentWord {
    return $WordModelCopyWith<$Res>(_value.currentWord, (value) {
      return _then(_value.copyWith(currentWord: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$GameModelImplCopyWith<$Res> implements $GameModelCopyWith<$Res> {
  factory _$$GameModelImplCopyWith(_$GameModelImpl value, $Res Function(_$GameModelImpl) then) =
      __$$GameModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      PlayerModel currentPlayer,
      WordModel currentWord,
      Status status,
      List<String> uids,
      List<String> correctGuess,
      List<PlayerModel> players,
      List<String> online,
      List<LineModel> currentArt,
      int numOfPlayers,
      int numOfArts});

  @override
  $PlayerModelCopyWith<$Res> get currentPlayer;
  @override
  $WordModelCopyWith<$Res> get currentWord;
}

/// @nodoc
class __$$GameModelImplCopyWithImpl<$Res> extends _$GameModelCopyWithImpl<$Res, _$GameModelImpl>
    implements _$$GameModelImplCopyWith<$Res> {
  __$$GameModelImplCopyWithImpl(_$GameModelImpl _value, $Res Function(_$GameModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? currentPlayer = null,
    Object? currentWord = null,
    Object? status = null,
    Object? uids = null,
    Object? correctGuess = null,
    Object? players = null,
    Object? online = null,
    Object? currentArt = null,
    Object? numOfPlayers = null,
    Object? numOfArts = null,
  }) {
    return _then(_$GameModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      currentPlayer: null == currentPlayer
          ? _value.currentPlayer
          : currentPlayer // ignore: cast_nullable_to_non_nullable
              as PlayerModel,
      currentWord: null == currentWord
          ? _value.currentWord
          : currentWord // ignore: cast_nullable_to_non_nullable
              as WordModel,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as Status,
      uids: null == uids
          ? _value._uids
          : uids // ignore: cast_nullable_to_non_nullable
              as List<String>,
      correctGuess: null == correctGuess
          ? _value._correctGuess
          : correctGuess // ignore: cast_nullable_to_non_nullable
              as List<String>,
      players: null == players
          ? _value._players
          : players // ignore: cast_nullable_to_non_nullable
              as List<PlayerModel>,
      online: null == online
          ? _value._online
          : online // ignore: cast_nullable_to_non_nullable
              as List<String>,
      currentArt: null == currentArt
          ? _value._currentArt
          : currentArt // ignore: cast_nullable_to_non_nullable
              as List<LineModel>,
      numOfPlayers: null == numOfPlayers
          ? _value.numOfPlayers
          : numOfPlayers // ignore: cast_nullable_to_non_nullable
              as int,
      numOfArts: null == numOfArts
          ? _value.numOfArts
          : numOfArts // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameModelImpl extends _GameModel {
  const _$GameModelImpl(
      {required this.id,
      required this.createdAt,
      required this.currentPlayer,
      required this.currentWord,
      this.status = Status.open,
      final List<String> uids = const [],
      final List<String> correctGuess = const [],
      final List<PlayerModel> players = const [],
      final List<String> online = const [],
      final List<LineModel> currentArt = const [],
      this.numOfPlayers = 4,
      this.numOfArts = 0})
      : _uids = uids,
        _correctGuess = correctGuess,
        _players = players,
        _online = online,
        _currentArt = currentArt,
        super._();

  factory _$GameModelImpl.fromJson(Map<String, dynamic> json) => _$$GameModelImplFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final PlayerModel currentPlayer;
  @override
  final WordModel currentWord;
  @override
  @JsonKey()
  final Status status;
  final List<String> _uids;
  @override
  @JsonKey()
  List<String> get uids {
    if (_uids is EqualUnmodifiableListView) return _uids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_uids);
  }

  final List<String> _correctGuess;
  @override
  @JsonKey()
  List<String> get correctGuess {
    if (_correctGuess is EqualUnmodifiableListView) return _correctGuess;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctGuess);
  }

  final List<PlayerModel> _players;
  @override
  @JsonKey()
  List<PlayerModel> get players {
    if (_players is EqualUnmodifiableListView) return _players;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_players);
  }

  final List<String> _online;
  @override
  @JsonKey()
  List<String> get online {
    if (_online is EqualUnmodifiableListView) return _online;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_online);
  }

  final List<LineModel> _currentArt;
  @override
  @JsonKey()
  List<LineModel> get currentArt {
    if (_currentArt is EqualUnmodifiableListView) return _currentArt;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_currentArt);
  }

  @override
  @JsonKey()
  final int numOfPlayers;
  @override
  @JsonKey()
  final int numOfArts;

  @override
  String toString() {
    return 'GameModel(id: $id, createdAt: $createdAt, currentPlayer: $currentPlayer, currentWord: $currentWord, status: $status, uids: $uids, correctGuess: $correctGuess, players: $players, online: $online, currentArt: $currentArt, numOfPlayers: $numOfPlayers, numOfArts: $numOfArts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) || other.createdAt == createdAt) &&
            (identical(other.currentPlayer, currentPlayer) ||
                other.currentPlayer == currentPlayer) &&
            (identical(other.currentWord, currentWord) || other.currentWord == currentWord) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._uids, _uids) &&
            const DeepCollectionEquality().equals(other._correctGuess, _correctGuess) &&
            const DeepCollectionEquality().equals(other._players, _players) &&
            const DeepCollectionEquality().equals(other._online, _online) &&
            const DeepCollectionEquality().equals(other._currentArt, _currentArt) &&
            (identical(other.numOfPlayers, numOfPlayers) || other.numOfPlayers == numOfPlayers) &&
            (identical(other.numOfArts, numOfArts) || other.numOfArts == numOfArts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      createdAt,
      currentPlayer,
      currentWord,
      status,
      const DeepCollectionEquality().hash(_uids),
      const DeepCollectionEquality().hash(_correctGuess),
      const DeepCollectionEquality().hash(_players),
      const DeepCollectionEquality().hash(_online),
      const DeepCollectionEquality().hash(_currentArt),
      numOfPlayers,
      numOfArts);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith =>
      __$$GameModelImplCopyWithImpl<_$GameModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameModelImplToJson(
      this,
    );
  }
}

abstract class _GameModel extends GameModel {
  const factory _GameModel(
      {required final String id,
      required final DateTime createdAt,
      required final PlayerModel currentPlayer,
      required final WordModel currentWord,
      final Status status,
      final List<String> uids,
      final List<String> correctGuess,
      final List<PlayerModel> players,
      final List<String> online,
      final List<LineModel> currentArt,
      final int numOfPlayers,
      final int numOfArts}) = _$GameModelImpl;
  const _GameModel._() : super._();

  factory _GameModel.fromJson(Map<String, dynamic> json) = _$GameModelImpl.fromJson;

  @override
  String get id;
  @override
  DateTime get createdAt;
  @override
  PlayerModel get currentPlayer;
  @override
  WordModel get currentWord;
  @override
  Status get status;
  @override
  List<String> get uids;
  @override
  List<String> get correctGuess;
  @override
  List<PlayerModel> get players;
  @override
  List<String> get online;
  @override
  List<LineModel> get currentArt;
  @override
  int get numOfPlayers;
  @override
  int get numOfArts;
  @override
  @JsonKey(ignore: true)
  _$$GameModelImplCopyWith<_$GameModelImpl> get copyWith => throw _privateConstructorUsedError;
}
