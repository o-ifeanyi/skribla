// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../game_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameModelImpl _$$GameModelImplFromJson(Map<String, dynamic> json) =>
    _$GameModelImpl(
      id: json['id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      currentPlayer:
          PlayerModel.fromJson(json['current_player'] as Map<String, dynamic>),
      currentWord:
          WordModel.fromJson(json['current_word'] as Map<String, dynamic>),
      status:
          $enumDecodeNullable(_$StatusEnumMap, json['status']) ?? Status.open,
      uids:
          (json['uids'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      correctGuess: (json['correct_guess'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      players: (json['players'] as List<dynamic>?)
              ?.map((e) => PlayerModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      online: (json['online'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      currentArt: (json['current_art'] as List<dynamic>?)
              ?.map((e) => LineModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      numOfPlayers: (json['num_of_players'] as num?)?.toInt() ?? 4,
    );

Map<String, dynamic> _$$GameModelImplToJson(_$GameModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'current_player': instance.currentPlayer.toJson(),
      'current_word': instance.currentWord.toJson(),
      'status': _$StatusEnumMap[instance.status]!,
      'uids': instance.uids,
      'correct_guess': instance.correctGuess,
      'players': instance.players.map((e) => e.toJson()).toList(),
      'online': instance.online,
      'current_art': instance.currentArt.map((e) => e.toJson()).toList(),
      'num_of_players': instance.numOfPlayers,
    };

const _$StatusEnumMap = {
  Status.open: 'open',
  Status.closed: 'closed',
  Status.complete: 'complete',
};
