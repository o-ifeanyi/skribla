import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:skribla/src/app/game/data/models/line_model.dart';
import 'package:skribla/src/app/game/data/models/player_model.dart';
import 'package:skribla/src/app/game/data/models/word_model.dart';

part 'generated/exhibit_model.g.dart';

@JsonSerializable()
class ExhibitModel {
  const ExhibitModel({
    required this.id,
    required this.player,
    required this.word,
    required this.art,
    required this.createdAt,
  });

  factory ExhibitModel.fromJson(Map<String, dynamic> json) => _$ExhibitModelFromJson(json);

  Map<String, dynamic> toJson() => _$ExhibitModelToJson(this);

  final String id;
  final PlayerModel player;
  final WordModel word;
  final List<LineModel> art;
  final DateTime createdAt;
}
