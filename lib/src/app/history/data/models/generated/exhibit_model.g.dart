// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../exhibit_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExhibitModel _$ExhibitModelFromJson(Map<String, dynamic> json) => ExhibitModel(
      id: json['id'] as String,
      player: PlayerModel.fromJson(json['player'] as Map<String, dynamic>),
      word: WordModel.fromJson(json['word'] as Map<String, dynamic>),
      art: (json['art'] as List<dynamic>)
          .map((e) => LineModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$ExhibitModelToJson(ExhibitModel instance) => <String, dynamic>{
      'id': instance.id,
      'player': instance.player.toJson(),
      'word': instance.word.toJson(),
      'art': instance.art.map((e) => e.toJson()).toList(),
      'created_at': instance.createdAt.toIso8601String(),
    };
